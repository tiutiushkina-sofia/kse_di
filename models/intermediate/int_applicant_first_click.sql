select
    click_id,
    applicant_id,
    campaign_id,
    click_timestamp,
    row_number() over( partition by applicant_id order by click_timestamp asc) as click_rank
from "dev"."main"."stg_ad_clicks"