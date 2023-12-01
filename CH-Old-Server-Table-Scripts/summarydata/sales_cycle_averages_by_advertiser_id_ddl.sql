CREATE TABLE summarydata.sales_cycle_averages_by_advertiser_id
(
 `day` Date,
 `advertiser_id` Int32,
 `avg_sales_cycle_time_30_day` Nullable(Int32),
 `avg_sales_cycle_time_30_day_string` Nullable(String),
 `avg_sales_cycle_time_7_day` Nullable(Int32),
 `avg_sales_cycle_time_7_day_string` Nullable(String),
 `avg_sales_cycle_time_1_day` Nullable(Int32),
 `avg_sales_cycle_time_1_day_string` Nullable(String)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(day)
ORDER BY (day, advertiser_id)
SETTINGS index_granularity = 8192
