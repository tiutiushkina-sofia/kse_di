

select * from "dev"."main"."int_daily_campaign_clicks"

    where click_date >= (select max(click_date) from "dev"."main"."fct_daily_clicks")
