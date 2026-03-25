select
    a.applicant_id,
    a.lead_source,
    a.registration_date,
    p.program_name,
    p.degree
from "dev"."main"."stg_applicants" a
left join "dev"."main"."stg_programs" p on a.target_program_id = p.program_id