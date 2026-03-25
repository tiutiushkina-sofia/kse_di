select
    program_id,
    
    lower(trim(program_name))
 as program_name,
    degree
from "dev"."main"."base_programs"