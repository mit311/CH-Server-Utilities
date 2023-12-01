CREATE TABLE info_test.metros
(
 `metro_id` Int32,
 `name` String,
 `country` String
)
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
PRIMARY KEY metro_id
ORDER BY metro_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
