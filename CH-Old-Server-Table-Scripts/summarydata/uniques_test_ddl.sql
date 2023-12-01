CREATE TABLE summarydata.uniques_test
(
 `advertiser_id` Int32,
 `hour` DateTime,
 `uniques_arr` Array(Nullable(String))
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(hour)
ORDER BY (advertiser_id, hour)
SETTINGS index_granularity = 8192
