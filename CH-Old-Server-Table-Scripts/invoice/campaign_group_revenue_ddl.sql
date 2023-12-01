CREATE TABLE invoice.campaign_group_revenue
(
 `advertiser_id` Int32,
 `campaign_group_id` Int32,
 `invoice_id` Int32,
 `invoice_date` Date,
 `begin_date` Nullable(Date),
 `end_date` Nullable(Date),
 `due_date` Nullable(Date),
 `currency` Nullable(String),
 `budget` Nullable(Decimal(38, 19)),
 `uncapped_revenue` Nullable(Decimal(38, 19)),
 `revenue` Nullable(Decimal(38, 19)),
 `user_id` Nullable(Int32)
)
ENGINE = MergeTree
ORDER BY (advertiser_id, campaign_group_id, invoice_date, invoice_id)
SETTINGS index_granularity = 8192, allow_nullable_key = 1
