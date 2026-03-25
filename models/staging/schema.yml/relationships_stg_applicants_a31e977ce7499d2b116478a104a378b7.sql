
    
    

with child as (
    select target_program_id as from_field
    from "dev"."main"."stg_applicants"
    where target_program_id is not null
),

parent as (
    select program_id as to_field
    from "dev"."main"."stg_programs"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


