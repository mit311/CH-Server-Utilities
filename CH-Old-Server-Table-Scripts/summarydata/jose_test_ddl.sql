CREATE TABLE summarydata.jose_test
(
 `hour` DateTime64(6),
 `advertiser_id` Int32
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(hour)
ORDER BY (advertiser_id, hour)
SETTINGS index_granularity = 8192
