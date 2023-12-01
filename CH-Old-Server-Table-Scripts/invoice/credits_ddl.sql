CREATE TABLE invoice.credits
(
 `credit_id` Int32,
 `advertiser_id` Int32,
 `amount` Decimal(12, 2),
 `credit_reason` Int16,
 `credit_status_id` Int16,
 `requested_by_user_id` Int32,
 `invoice_id` Nullable(Int32),
 `request_note` Nullable(String),
 `campaign_group_id` Nullable(Int32),
 `approved_by_user_id` Nullable(Int32),
 `approval_note` Nullable(String),
 `user_id` Nullable(Int32),
 `create_time` DateTime64(6)
)
ENGINE = MergeTree
ORDER BY credit_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
