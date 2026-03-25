select
    application_id,
    applicant_id,
    status,
    status_updated_at,
    row_number() over (partition by applicant_id order by status_updated_at desc) as status_rank
from "dev"."main"."stg_applications"