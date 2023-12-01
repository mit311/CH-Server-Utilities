CREATE TABLE info.avg_sales_cycle_by_advertiser_by_day_1
(
 `day` Nullable(Date),
 `advertiser_id` Nullable(Int32),
 `sales_cycle_time` Nullable(String)
)
ENGINE = MergeTree
ORDER BY advertiser_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
