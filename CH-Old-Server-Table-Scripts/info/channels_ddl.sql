CREATE TABLE info.channels
(
 `channel_id` Int32,
 `name` String
)
ENGINE = MergeTree
ORDER BY channel_id
SETTINGS allow_nullable_key = 1, index_granularity = 8192
