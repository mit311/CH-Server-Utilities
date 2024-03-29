DROP TABLE summarydata.all_facts_by_day_agg_mv ON CLUSTER 'reporting-dev01';

CREATE MATERIALIZED VIEW summarydata.all_facts_by_day_agg_mv ON CLUSTER 'reporting-dev01'
            TO summarydata.all_facts_local_by_day_aggregated
            (
 `day` Date,
 `advertiser_id` Int32,
 `campaign_group_id` Int32,
 `campaign_id` Int32,
 `channel_id` Int32,
 `objective_id` Int32,
 `group_id` Int32,
 `creative_id` Int32,
 `private_marketplace_id` String,
 `country` LowCardinality(String),
 `metro_id` Int32,
 `region` LowCardinality(String),
 `city` LowCardinality(String),
 `postal_code` LowCardinality(String),
 `domain` String,
 `supply_vendor` String,
 `device_type` String,
    display_impressions                  AggregateFunction(sum, Int32),
    ctv_impressions                      AggregateFunction(sum, Int32),
    media_cost                           AggregateFunction(sum, Decimal(18, 9)),
    fee_cost                             AggregateFunction(sum, Decimal(18, 9)),
    partner_cost                         AggregateFunction(sum, Decimal(18, 9)),
    data_cost                            AggregateFunction(sum, Decimal(18, 9)),
    media_spend                          AggregateFunction(sum, Decimal(18, 9)),
    data_spend                           AggregateFunction(sum, Decimal(18, 9)),
    platform_spend                       AggregateFunction(sum, Decimal(18, 9)),
    legacy_spend                         AggregateFunction(sum, Decimal(18, 9)),
    ctv_spend                            AggregateFunction(sum, Decimal(18, 9)),
    views                                AggregateFunction(sum, Int32),
    clicks                               AggregateFunction(sum, Int32),
    view_conversions                     AggregateFunction(sum, Int32),
    click_conversions                    AggregateFunction(sum, Int32),
    view_order_value                     AggregateFunction(sum, Decimal(18, 9)),
    click_order_value                    AggregateFunction(sum, Decimal(18, 9)),
    view_impression                      AggregateFunction(sum, Int32),
    view_viewed                          AggregateFunction(sum, Int32),
    view_untrackable                     AggregateFunction(sum, Int32),
    vast_start                           AggregateFunction(sum, Int32),
    vast_firstquartile                   AggregateFunction(sum, Int32),
    vast_midpoint                        AggregateFunction(sum, Int32),
    vast_thirdquartile                   AggregateFunction(sum, Int32),
    vast_complete                        AggregateFunction(sum, Int32),
    uniques_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    unlinked_spend                       AggregateFunction(sum, Decimal(18, 9)),
    bids                                 AggregateFunction(sum, Int32),
    new_visitors                         AggregateFunction(sum, Int32),
    raw_existing_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    raw_new_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    existing_users_reached_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    new_users_reached_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    existing_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    new_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    new_to_file                          AggregateFunction(sum, Int32),
    raw_visits                           AggregateFunction(sum, Int32),
    raw_conversions                      AggregateFunction(sum, Int32),
    visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    raw_order_value                      AggregateFunction(sum, Int64),
    first_touch_visits                   AggregateFunction(sum, Int32),
    last_tv_touch_clicks                 AggregateFunction(sum, Int32),
    last_tv_touch_views                  AggregateFunction(sum, Int32),
    last_tv_touch_click_conversions      AggregateFunction(sum, Int32),
    last_tv_touch_view_conversions       AggregateFunction(sum, Int32),
    last_tv_touch_click_order_value      AggregateFunction(sum, Decimal(18, 9)),
    last_tv_touch_view_order_value       AggregateFunction(sum, Decimal(18, 9)),
    last_touch_clicks                    AggregateFunction(sum, Int32),
    last_touch_views                     AggregateFunction(sum, Int32),
    last_touch_click_conversions         AggregateFunction(sum, Int32),
    last_touch_click_order_value         AggregateFunction(sum, Decimal(18, 9)),
    last_touch_view_order_value          AggregateFunction(sum, Decimal(18, 9)),
    visits_assist                        AggregateFunction(sum, Int32),
    conversions_assist_click             AggregateFunction(sum, Int32),
    conversions_assist_view              AggregateFunction(sum, Int32),
    conversions_assist_click_order_value AggregateFunction(sum, Decimal(18, 9)),
    conversions_assist_view_order_value  AggregateFunction(sum, Decimal(18, 9)),
    last_touch_view_conversions          AggregateFunction(sum, Int32)
                )
AS
SELECT toDate(hour)                                   AS day,
       advertiser_id,
       campaign_group_id,
       campaign_id,
       channel_id,
       objective_id,
       group_id,
       creative_id,
       private_marketplace_id,
       country,
       metro_id,
       region,
       city,
       postal_code,
       domain,
       supply_vendor,
       device_type,
       sumState(display_impressions)                       AS display_impressions,
       sumState(ctv_impressions)                           AS ctv_impressions,
       sumState(media_cost)                                AS media_cost,
       sumState(fee_cost)                                  AS fee_cost,
       sumState(partner_cost)                              AS partner_cost,
       sumState(data_cost)                                 AS data_cost,
       sumState(media_spend)                               AS media_spend,
       sumState(data_spend)                                AS data_spend,
       sumState(platform_spend)                            AS platform_spend,
       sumState(legacy_spend)                              AS legacy_spend,
       sumState(ctv_spend)                                 AS ctv_spend,
       sumState(views)                                     AS views,
       sumState(clicks)                                    AS clicks,
       sumState(view_conversions)                          AS view_conversions,
       sumState(click_conversions)                         AS click_conversions,
       sumState(view_order_value)                          AS view_order_value,
       sumState(click_order_value)                         AS click_order_value,
       sumState(view_impression)                           AS view_impression,
       sumState(view_viewed)                               AS view_viewed,
       sumState(view_untrackable)                          AS view_untrackable,
       sumState(vast_start)                                AS vast_start,
       sumState(vast_firstquartile)                        AS vast_firstquartile,
       sumState(vast_midpoint)                             AS vast_midpoint,
       sumState(vast_thirdquartile)                        AS vast_thirdquartile,
       sumState(vast_complete)                             AS vast_complete,
       uniqArrayState(uniques_arr)                    AS uniques_arr,
       sumState(unlinked_spend)                            AS unlinked_spend,
       sumState(bids)                                      AS bids,
       sumState(new_visitors)                              AS new_visitors,
       uniqArrayState(raw_existing_site_visitors_arr) AS raw_existing_site_visitors_arr,
       uniqArrayState(raw_new_site_visitors_arr)      AS raw_new_site_visitors_arr,
       uniqArrayState(existing_users_reached_arr)     AS existing_users_reached_arr,
       uniqArrayState(new_users_reached_arr)          AS new_users_reached_arr,
       uniqArrayState(existing_site_visitors_arr)     AS existing_site_visitors_arr,
       uniqArrayState(new_site_visitors_arr)          AS new_site_visitors_arr,
       uniqArrayState(site_visitors_arr)              AS site_visitors_arr,
       sumState(new_to_file)                               AS new_to_file,
       sumState(raw_visits)                                AS raw_visits,
       sumState(raw_conversions)                           AS raw_conversions,
       uniqArrayState(visitors_arr)                   AS visitors_arr,
       sumState(raw_order_value)                           AS raw_order_value,
       sumState(first_touch_visits)                        AS first_touch_visits,
       sumState(last_tv_touch_clicks)                      AS last_tv_touch_clicks,
       sumState(last_tv_touch_views)                       AS last_tv_touch_views,
       sumState(last_tv_touch_click_conversions)           AS last_tv_touch_click_conversions,
       sumState(last_tv_touch_view_conversions)            AS last_tv_touch_view_conversions,
       sumState(last_tv_touch_click_order_value)           AS last_tv_touch_click_order_value,
       sumState(last_tv_touch_view_order_value)            AS last_tv_touch_view_order_value,
       sumState(last_touch_clicks)                         AS last_touch_clicks,
       sumState(last_touch_views)                          AS last_touch_views,
       sumState(last_touch_click_conversions)              AS last_touch_click_conversions,
       sumState(last_touch_click_order_value)              AS last_touch_click_order_value,
       sumState(last_touch_view_order_value)               AS last_touch_view_order_value,
       sumState(visits_assist)                             AS visits_assist,
       sumState(conversions_assist_click)                  AS conversions_assist_click,
       sumState(conversions_assist_view)                   AS conversions_assist_view,
       sumState(conversions_assist_click_order_value)      AS conversions_assist_click_order_value,
       sumState(conversions_assist_view_order_value)       AS conversions_assist_view_order_value,
       sumState(last_touch_view_conversions)               AS last_touch_view_conversions
FROM summarydata.all_facts_local_daily
GROUP BY day,
         advertiser_id,
         campaign_group_id,
         campaign_id,
         channel_id,
         objective_id,
         group_id,
         creative_id,
         country,
         metro_id,
         region,
         city,
         postal_code,
         domain,
         private_marketplace_id,
         supply_vendor,
         device_type;
