import json
import os
import random

JSON_DIR = "/Users/sofiatiutiuskina/my_airflow_project/include/telephony"
os.makedirs(JSON_DIR, exist_ok=True)

calls_data = [
    {"call_id": 1, "status": "answered", "desc": "Клієнт запитував про налаштування роутера."},
    {"call_id": 2, "status": "answered", "desc": "Допомога зі зміною тарифного плану."},
    {"call_id": 3, "status": "missed", "desc": "No answer."},
    {"call_id": 4, "status": "answered", "desc": "Скаржився на низьку швидкість інтернету."},
    {"call_id": 5, "status": "missed", "desc": "No answer."},
    {"call_id": 6, "status": "answered", "desc": "Питання щодо останнього рахунку."},
    {"call_id": 7, "status": "answered", "desc": "Запит на виклик майстра додому."},
    {"call_id": 8, "status": "answered", "desc": "Консультація по новому обладнанню."},
    {"call_id": 9, "status": "missed", "desc": "No answer."},
    {"call_id": 10, "status": "answered", "desc": "Підтвердження оплати заборгованості."},
    {"call_id": 11, "status": "answered", "desc": "Тестовий новий дзвінок"},
    {"call_id": 12, "status": "answered", "desc": "Клієнт цікавиться новими курсами KSE."}
]

for call in calls_data:
    duration = random.randint(15, 600) if call["status"] == "answered" else 0

    json_content = {
        "call_id": call["call_id"],
        "duration_sec": duration,
        "short_description": call["desc"]
    }

    file_path = os.path.join(JSON_DIR, f"{call['call_id']}.json")
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(json_content, f, indent=4, ensure_ascii=False)
