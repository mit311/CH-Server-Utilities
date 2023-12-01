CREATE TABLE info_test.campaign_statuses
(
 `campaign_status_id` Int32,
 `name` String,
 `created_at` DateTime64(6)
)
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
PRIMARY KEY campaign_status_id
ORDER BY campaign_status_id
SETTINGS index_granularity = 8192
