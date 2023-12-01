CREATE VIEW invoice.invoices
(
 `invoice_id` Int32,
 `create_time` DateTime64(6),
 `advertiser_id` Int32,
 `invoice_date` Date,
 `begin_date` Date,
 `time` Date,
 `end_date` Date,
 `due_date` Date,
 `currency` String,
 `budget` Nullable(Decimal(12, 2)),
 `uncapped_revenue` Decimal(12, 2),
 `subtotal` Decimal(12, 2),
 `discount` Decimal(12, 2),
 `approved_time` Nullable(DateTime64(6)),
 `void_time` Nullable(DateTime64(6)),
 `full_file_url` Nullable(String),
 `default_template` Nullable(String),
 `user_id` Nullable(Int32),
 `note` Nullable(String),
 `invoice_uuid` Nullable(UUID),
 `company_name` Nullable(String),
 `status_name` String,
 `prior_balance` Nullable(Decimal(12, 2)),
 `approved` Bool,
 `paid` Bool,
 `overdue` Bool,
 `voided` Bool,
 `sent_time` Nullable(DateTime64(6)),
 `sent_by` Nullable(String),
 `purchase_order_number` Nullable(String),
 `total` Decimal(18, 2)
) AS
WITH
 c AS
 (
 SELECT
 credits.invoice_id AS invoice_id,
 CAST(sum(credits.amount), \'Decimal(12, 2)\') AS amount
 FROM invoice.credits
 WHERE credits.credit_status_id = 2
 GROUP BY credits.invoice_id
 ),
 cte_advertiser AS
 (
 SELECT
 advertiser_id,
 company_name
 FROM info.advertisers
 )
SELECT
 i.invoice_id AS invoice_id,
 i.create_time AS create_time,
 i.advertiser_id AS advertiser_id,
 i.invoice_date AS invoice_date,
 i.begin_date AS begin_date,
 i.begin_date AS time,
 i.end_date AS end_date,
 i.due_date AS due_date,
 i.currency AS currency,
 i.budget AS budget,
 i.uncapped_revenue AS uncapped_revenue,
 i.amount AS subtotal,
 c.amount AS discount,
 i.approved_time AS approved_time,
 i.void_time AS void_time,
 i.full_file_url AS full_file_url,
 i.default_template AS default_template,
 i.user_id AS user_id,
 i.note AS note,
 i.invoice_uuid AS invoice_uuid,
 a.company_name AS company_name,
 s.name AS status_name,
 i.prior_balance AS prior_balance,
 s.approved AS approved,
 s.paid AS paid,
 s.overdue AS overdue,
 s.voided AS voided,
 i.sent_time AS sent_time,
 i.sent_by AS sent_by,
 i.purchase_order_number AS purchase_order_number,
 i.amount + ifNull(c.amount, CAST(0, \'Decimal(12, 2)\')) AS total
FROM invoice.raw_invoices AS i
LEFT JOIN c ON i.invoice_id = c.invoice_id
LEFT JOIN invoice.invoice_status AS s ON s.invoice_id = c.invoice_id
LEFT JOIN cte_advertiser AS a ON i.advertiser_id = a.advertiser_id
