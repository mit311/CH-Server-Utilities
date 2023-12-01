CREATE TABLE summarydata.test_dt
(
 `hour` DateTime64(3),
 `advertiser_id` Int32,
 `campaign_group_id` Int32 DEFAULT 0,
 `unlinked_spend` Decimal(18, 8) DEFAULT 0.,
 `city` LowCardinality(String) DEFAULT \'\',
 `new_site_visitors_arr` Array(String) DEFAULT []
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(hour)
ORDER BY (advertiser_id, hour)
SETTINGS index_granularity = 8192
