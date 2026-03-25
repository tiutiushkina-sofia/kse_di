
    
    

select
    applicant_id as unique_field,
    count(*) as n_records

from "dev"."main"."stg_applicants"
where applicant_id is not null
group by applicant_id
having count(*) > 1


