CREATE TABLE summarydata.stg_all_facts_nn
(
 `hour` DateTime64(6),
 `advertiser_id` Int32,
 `campaign_group_id` Nullable(Int32),
 `campaign_id` Nullable(Int32),
 `channel_id` Nullable(Int32),
 `objective_id` Nullable(Int32),
 `group_id` Nullable(Int32),
 `creative_id` Nullable(Int32),
 `private_marketplace_id` Nullable(String),
 `country` LowCardinality(Nullable(String)),
 `metro_id` Nullable(Int32),
 `region` LowCardinality(Nullable(String)),
 `city` LowCardinality(Nullable(String)),
 `postal_code` LowCardinality(Nullable(String)),
 `domain` Nullable(String),
 `display_impressions` Nullable(Int64),
 `ctv_impressions` Nullable(Int64),
 `media_cost` Nullable(Decimal(38, 19)),
 `fee_cost` Nullable(Decimal(38, 19)),
 `partner_cost` Nullable(Decimal(38, 19)),
 `data_cost` Nullable(Decimal(38, 19)),
 `media_spend` Nullable(Decimal(38, 19)),
 `data_spend` Nullable(Decimal(38, 19)),
 `platform_spend` Nullable(Decimal(38, 19)),
 `legacy_spend` Nullable(Decimal(38, 19)),
 `ctv_spend` Nullable(Decimal(38, 19)),
 `views` Nullable(Int64),
 `clicks` Nullable(Int64),
 `view_conversions` Nullable(Int64),
 `click_conversions` Nullable(Int64),
 `view_order_value` Nullable(Decimal(38, 19)),
 `click_order_value` Nullable(Decimal(38, 19)),
 `view_impression` Nullable(Int64),
 `view_viewed` Nullable(Int64),
 `view_untrackable` Nullable(Int64),
 `vast_start` Nullable(Int64),
 `vast_firstquartile` Nullable(Int64),
 `vast_midpoint` Nullable(Int64),
 `vast_thirdquartile` Nullable(Int64),
 `vast_complete` Nullable(Int64),
 `uniques_arr` Array(Nullable(String)),
 `unlinked_spend` Nullable(Decimal(38, 19)),
 `supply_vendor` Nullable(String),
 `bids` Nullable(Int64),
 `new_visitors` Nullable(Int64),
 `raw_existing_site_visitors_arr` Array(Nullable(String)),
 `raw_new_site_visitors_arr` Array(Nullable(String)),
 `existing_users_reached_arr` Array(Nullable(String)),
 `new_users_reached_arr` Array(Nullable(String)),
 `existing_site_visitors_arr` Array(Nullable(String)),
 `new_site_visitors_arr` Array(Nullable(String)),
 `site_visitors_arr` Array(Nullable(String)),
 `new_to_file` Nullable(Int64),
 `raw_visits` Nullable(Int64),
 `raw_conversions` Nullable(Int64),
 `visitors_arr` Array(Nullable(String)),
 `raw_order_value` Nullable(Int64),
 `first_touch_visits` Nullable(Int64),
 `device_type` Nullable(String),
 `last_tv_touch_clicks` Nullable(Int64),
 `last_tv_touch_views` Nullable(Int64),
 `last_tv_touch_click_conversions` Nullable(Int64),
 `last_tv_touch_view_conversions` Nullable(Int64),
 `last_tv_touch_click_order_value` Nullable(Decimal(38, 19)),
 `last_tv_touch_view_order_value` Nullable(Decimal(38, 19)),
 `last_touch_clicks` Nullable(Int64),
 `last_touch_views` Nullable(Int64),
 `last_touch_click_conversions` Nullable(Int64),
 `last_touch_click_order_value` Nullable(Decimal(38, 19)),
 `last_touch_view_order_value` Nullable(Decimal(38, 19)),
 `visits_assist` Nullable(Int64),
 `conversions_assist_click` Nullable(Int64),
 `conversions_assist_view` Nullable(Int64),
 `conversions_assist_click_order_value` Nullable(Decimal(38, 19)),
 `conversions_assist_view_order_value` Nullable(Decimal(38, 19)),
 `last_touch_view_conversions` Nullable(Int64)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(hour)
ORDER BY (advertiser_id, hour)
SETTINGS index_granularity = 8192
