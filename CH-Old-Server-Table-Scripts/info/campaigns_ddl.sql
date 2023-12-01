CREATE TABLE info.campaigns
(
 `campaign_id` Int32,
 `advertiser_id` Int32,
 `name` String,
 `description` Nullable(String),
 `start_time` DateTime64(6),
 `end_time` Nullable(DateTime64(6)),
 `create_time` Nullable(DateTime64(6)),
 `control_percentage` Int32,
 `is_test` UInt8,
 `clickpass_click_ttl` Nullable(String),
 `is_click_opt` UInt8,
 `campaign_group_id` Nullable(Int32),
 `deleted` Nullable(UInt8),
 `partner_channel_objective_id` Nullable(Int32),
 `campaign_status_id` Nullable(Int32),
 `click_url` Nullable(String),
 `update_time` Nullable(DateTime64(6)),
 `objective_id` Nullable(Int32),
 `channel_id` Nullable(Int32),
 `partner_id` Nullable(Int32),
 `fb_ad_type_id` Nullable(Int32),
 `campaign_template_id` Nullable(Int32),
 `segmentation_default_id` Nullable(Int32),
 `dso_manage_budget` UInt8,
 `audience_type_id` Nullable(Int32),
 `audience_source_id` Nullable(Int32),
 `budget_floor` Decimal(3, 2),
 `budget_ceiling` Decimal(3, 2),
 `user_id` Nullable(Int32)
)
ENGINE = MergeTree
ORDER BY campaign_id
SETTINGS allow_nullable_key = 1, index_granularity = 8192
