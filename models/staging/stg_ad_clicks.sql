

select
    click_id,
    applicant_id,
    campaign_id,
    cast(click_timestamp as timestamp) as click_timestamp,
    device_type
from "dev"."main"."base_ad_clicks"

    
        where cast(click_timestamp as timestamp) >= (select max(click_timestamp) from "dev"."main"."stg_ad_clicks")
    