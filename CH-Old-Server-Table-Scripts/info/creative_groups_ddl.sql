CREATE TABLE info.creative_groups
(
 `group_id` Int32,
 `campaign_id` Int32,
 `name` String,
 `click_url` Nullable(String),
 `weight` Int32,
 `imp_limit_day` Nullable(Int32),
 `imp_limit_user_day` Nullable(Int32),
 `active` UInt8,
 `escalating_order` Nullable(Int32),
 `escalation_type_id` Nullable(Int16),
 `escalation_limit` Nullable(Int16),
 `control_percentage` Int32,
 `is_control` Nullable(UInt8),
 `url_prefix` Nullable(String),
 `url_suffix` Nullable(String),
 `dpp_id` Nullable(String),
 `impression_tracking` Nullable(String),
 `mycreative_group_id` Nullable(Int32),
 `template_group_id` Nullable(Int32),
 `snapshot` Nullable(String),
 `update_time` Nullable(DateTime64(6)),
 `create_time` Nullable(DateTime64(6)),
 `description` Nullable(String),
 `dpp_filter` Nullable(String),
 `display_url` Nullable(String),
 `parent_group_id` Nullable(Int32),
 `ordinal` Nullable(Int32),
 `user_id` Nullable(Int32),
 `mycreative_video_group_id` Nullable(Int32),
 `has_dynamic` Nullable(UInt8)
)
ENGINE = MergeTree
ORDER BY group_id
SETTINGS allow_nullable_key = 1, index_granularity = 8192
