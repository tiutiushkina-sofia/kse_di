from airflow import DAG
from airflow.providers.mysql.hooks.mysql import MySqlHook
from airflow.decorators import task
from datetime import datetime
from airflow.models import Variable
import json
import duckdb
from datetime import timedelta
import logging

def alert_on_failure(context):
    problem = context.get('task_instance')
    logging.warning(f"🚨Помилка - таска {problem.task_id} впала 🚨")

default_args = {
    'retries': 2,
    'retry_delay': timedelta(minutes=1),
    'on_failure_callback': alert_on_failure
}

with DAG(
    dag_id="enrichment_pipeline",
    default_args=default_args,
    start_date=datetime(2026, 3, 15),
    schedule='@hourly',
    catchup = True,
    max_active_runs=1
) as dag:

    @task
    def detect_new_calls():
        last_loaded_time = Variable.get("last_call_time", default_var= "2000-01-01 00:00:00")
        hook = MySqlHook(mysql_conn_id='mysql_default')
        sql = f"SELECT call_id FROM call_center.calls WHERE call_time > '{last_loaded_time}'"
        records = hook.get_records(sql)
        new_call_ids = [i[0] for i in records]
        logging.info(f"Виявлено нових дзвінків {len(new_call_ids)}")
        return new_call_ids

    new_calls = detect_new_calls()

    @task
    def load_telephony_details(call_ids):
        telephony_data = []
        cnt = 0
        for j in call_ids:
            path = f"/usr/local/airflow/include/telephony/{j}.json"
            try:
                f = open(path)
                data = json.load(f)
                f.close()
                if "call_id" in data and "duration_sec" in data and "short_description" in data:
                    if data["duration_sec"] >= 0:
                        telephony_data.append(data)
                    else:
                        logging.warning(f"якість даних: від'ємна тривалість дзвінку у {j}.json")
                        cnt += 1
                else:
                    logging.warning(f"якість даних: не всі необхідні дані заповнені у {j}.json")
                    cnt += 1
            except (FileNotFoundError, json.JSONDecodeError):
                cnt += 1
                logging.warning(f"файл не знайдений, або пошкоджений {j}.json")
        logging.info(f" успішно завантажено json-файлів: {len(telephony_data)}")
        logging.warning(f" помикла/не знайдено json-файлів: {cnt}")
        return telephony_data
    telephony_data = load_telephony_details(new_calls)

    @task
    def transform_and_load_duckdb(call_ids, telephony_data):
        if not call_ids:
            logging.info("Нових дзвінків не знайдено")
            return
        hook = MySqlHook(mysql_conn_id='mysql_default')
        employees = hook.get_records("SELECT employee_id, full_name FROM call_center.employees")
        emp_dict = {row[0]: row[1] for row in employees}
        ids = str(call_ids).strip('[]')
        calls = hook.get_records(f"SELECT call_id, employee_id, call_time, phone FROM call_center.calls WHERE call_id in ({ids})")
        rows_to_insert = []
        processed_ids = set()
        for c in calls:
            call_id = c[0]
            if call_id in processed_ids:
                logging.warning(f"якість даних: повторний айді дзвінка {call_id}")
                continue
            processed_ids.add(call_id)
            emp_id = c[1]
            if emp_id not in emp_dict:
                logging.warning(f"якість даних: працівника {emp_id} не знайдено для дзвінка {c[0]}")
                continue
            json_item = next((item for item in telephony_data if item["call_id"] == c[0]), None)
            combined_row = (c[0], c[2], emp_dict[c[1]], c[3], json_item['duration_sec'], json_item['short_description'])
            rows_to_insert.append(combined_row)
        conn = duckdb.connect("/usr/local/airflow/include/calls.duckdb")
        conn.execute("CREATE TABLE IF NOT EXISTS calls_final(call_id INT PRIMARY KEY, call_time TIMESTAMP, emp_name TEXT, phone TEXT, duration INT, description TEXT)")
        conn.executemany("INSERT OR IGNORE INTO calls_final VALUES (?, ?, ?, ?, ?, ?)", rows_to_insert)
        logging.info(f"Нових дзвінків додано до бази {len(rows_to_insert)}")
        conn.close()
        latest_time = max(row[2] for row in calls)
        Variable.set("last_call_time", latest_time.strftime("%Y-%m-%d %H:%M:%S"))

    transform_and_load_duckdb(new_calls, telephony_data)



