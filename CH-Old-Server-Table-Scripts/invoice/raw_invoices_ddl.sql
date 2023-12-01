CREATE TABLE invoice.raw_invoices
(
 `invoice_id` Int32,
 `create_time` DateTime64(6),
 `advertiser_id` Int32,
 `invoice_date` Date,
 `begin_date` Date,
 `end_date` Date,
 `due_date` Date,
 `currency` String,
 `budget` Nullable(Decimal(12, 2)),
 `uncapped_revenue` Decimal(12, 2),
 `amount` Decimal(12, 2),
 `approved_time` Nullable(DateTime64(6)),
 `void_time` Nullable(DateTime64(6)),
 `full_file_url` Nullable(String),
 `default_template` Nullable(String),
 `user_id` Nullable(Int32),
 `note` Nullable(String),
 `invoice_uuid` Nullable(UUID),
 `prior_balance` Nullable(Decimal(12, 2)),
 `sent_time` Nullable(DateTime64(6)),
 `sent_by` Nullable(String),
 `audit_user_id` Nullable(Int32),
 `invoicing_address1` Nullable(String),
 `invoicing_address2` Nullable(String),
 `invoicing_city` Nullable(String),
 `invoicing_state` Nullable(String),
 `invoicing_zip` Nullable(String),
 `invoicing_country` Nullable(String),
 `purchase_order_number` Nullable(String),
 `invoicing_agency` Nullable(UInt8),
 `invoicing_last_name` Nullable(String),
 `invoicing_first_name` Nullable(String)
)
ENGINE = MergeTree
ORDER BY invoice_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
