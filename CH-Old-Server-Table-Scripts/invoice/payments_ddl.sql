CREATE TABLE invoice.payments
(
 `payment_id` Int32,
 `create_time` DateTime64(6),
 `invoice_id` Int32,
 `time` DateTime64(6),
 `amount` Decimal(12, 2),
 `note` Nullable(String),
 `payment_type_id` Nullable(Int32),
 `user_id` Nullable(Int32)
)
ENGINE = MergeTree
ORDER BY payment_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
