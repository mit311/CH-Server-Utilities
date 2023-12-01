CREATE VIEW invoice.statements
(
 `invoice_id` Nullable(Int32),
 `time` DateTime64(6),
 `type` String,
 `amount` Decimal(12, 2)
) AS
SELECT
 raw_invoices.invoice_id,
 raw_invoices.invoice_date AS time,
 \'Invoice\' AS type,
 raw_invoices.amount
FROM invoice.raw_invoices
WHERE (raw_invoices.approved_time IS NOT NULL) AND (raw_invoices.void_time IS NULL)
UNION ALL
SELECT
 credits.invoice_id,
 credits.create_time AS time,
 \'Credit\' AS type,
 credits.amount
FROM invoice.credits
INNER JOIN invoice.raw_invoices ON credits.invoice_id = raw_invoices.invoice_id
INNER JOIN info.advertisers AS a ON raw_invoices.advertiser_id = a.advertiser_id
WHERE credits.credit_status_id = 2
UNION ALL
SELECT
 payments.invoice_id,
 payments.time AS time,
 \'Payment\' AS type,
 payments.amount
FROM invoice.payments
INNER JOIN invoice.raw_invoices AS i ON payments.invoice_id = i.invoice_id
INNER JOIN info.advertisers AS a ON i.advertiser_id = a.advertiser_id
