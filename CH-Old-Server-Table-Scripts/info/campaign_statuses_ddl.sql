CREATE TABLE info.campaign_statuses
(
 `campaign_status_id` Int32,
 `name` Nullable(String),
 `created_at` Nullable(DateTime64(6))
)
ENGINE = MergeTree
ORDER BY campaign_status_id
SETTINGS allow_nullable_key = 1, index_granularity = 8192
