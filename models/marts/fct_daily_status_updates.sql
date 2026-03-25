

select
    status_updated_at as status_date,
    count(application_id) as total_updates
from "dev"."main"."stg_applications"


    where status_updated_at >= (select max(status_date) from "dev"."main"."fct_daily_status_updates")


group by status_date