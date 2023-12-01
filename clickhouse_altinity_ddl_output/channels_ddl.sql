CREATE TABLE info_test.channels
(
 `channel_id` Int32,
 `name` String
)
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
PRIMARY KEY channel_id
ORDER BY channel_id
SETTINGS index_granularity = 8192
