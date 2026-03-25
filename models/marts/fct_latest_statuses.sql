select
    application_id,
    applicant_id,
    status,
    status_updated_at
from "dev"."main"."int_application_latest_status"
where status_rank = 1