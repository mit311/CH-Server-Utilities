CREATE TABLE info.creative_sizes
(
 `creative_size_id` Int32,
 `width` Int32,
 `height` Int32,
 `description` String,
 `video` UInt8,
 `approve` UInt8,
 `web` Nullable(UInt8),
 `mobile` UInt8,
 `ctv` UInt8
)
ENGINE = MergeTree
ORDER BY creative_size_id
SETTINGS allow_nullable_key = 1, index_granularity = 8192
