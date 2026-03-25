select
    campaign_id,
    
    lower(trim(campaign_name))
 as campaign_name,
    platform,
    budget,
    start_date
from "dev"."main"."base_campaigns"