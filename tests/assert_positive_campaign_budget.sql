select
    campaign_id,
    budget
from {{ref('stg_campaigns')}}
where budget < 0