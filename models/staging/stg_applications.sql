

select
    application_id,
    applicant_id,
    
    lower(trim(status))
 as status,
    cast(status_updated_at as date) as status_updated_at
from "dev"."main"."base_applications"

    
        where cast(status_updated_at as date) >= (select max(status_updated_at) from "dev"."main"."stg_applications")
    