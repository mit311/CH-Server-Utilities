CREATE TABLE info.metros
(
 `metro_id` Int32,
 `name` String,
 `country` String
)
ENGINE = MergeTree
ORDER BY metro_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
