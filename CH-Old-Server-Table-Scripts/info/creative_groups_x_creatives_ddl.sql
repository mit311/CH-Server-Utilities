CREATE TABLE info.creative_groups_x_creatives
(
 `group_id` Int32,
 `creative_id` Int32,
 `click_url` Nullable(String),
 `active` UInt8,
 `url_prefix` Nullable(String),
 `url_suffix` Nullable(String),
 `dpp_id` Nullable(String),
 `impression_tracking` Nullable(String),
 `dpp_filter` Nullable(String),
 `user_id` Nullable(Int32)
)
ENGINE = MergeTree
ORDER BY (group_id, creative_id)
SETTINGS allow_nullable_key = 1, index_granularity = 8192
