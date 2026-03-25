select
    applicant_id,
    
    lower(trim(lead_source))
 as lead_source,
    target_program_id,
    cast(registration_date as date) as registration_date
from "dev"."main"."base_applicants"