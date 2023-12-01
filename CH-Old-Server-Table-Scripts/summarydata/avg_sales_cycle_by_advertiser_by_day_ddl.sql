CREATE TABLE summarydata.avg_sales_cycle_by_advertiser_by_day
(
 `day` Date,
 `advertiser_id` Int32,
 `sales_cycle_time` Nullable(Int64),
 `sales_cycle_time_string` Nullable(String)
)
ENGINE = MergeTree
PARTITION BY toYear(day)
ORDER BY (day, advertiser_id)
SETTINGS index_granularity = 8192
