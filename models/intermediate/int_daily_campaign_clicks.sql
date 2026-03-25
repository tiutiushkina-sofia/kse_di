

select
    cast(click_timestamp as date) as click_date,
    campaign_id,
    concat(cast(click_timestamp as date),'_', campaign_id) as date_campaign_id,
    count(click_id) as total_clicks
from "dev"."main"."stg_ad_clicks"

    
        where cast(click_timestamp as date) >= (select max(click_date) from "dev"."main"."int_daily_campaign_clicks")
    

group by click_date, campaign_id, date_campaign_id