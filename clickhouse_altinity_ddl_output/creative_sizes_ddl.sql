CREATE TABLE info_test.creative_sizes
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
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
ORDER BY creative_size_id
SETTINGS index_granularity = 8192
