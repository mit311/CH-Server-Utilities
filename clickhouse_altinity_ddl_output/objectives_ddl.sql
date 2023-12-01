CREATE TABLE info_test.objectives
(
 `objective_id` Int32,
 `name` String,
 `description` String DEFAULT \'\'
)
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
ORDER BY objective_id
SETTINGS index_granularity = 8192
