CREATE VIEW invoice.invoice_status
(
 `invoice_id` Int32,
 `invoice_date` Date,
 `name` String,
 `approved` Bool,
 `paid` Bool,
 `overdue` Bool,
 `voided` Bool,
 `due` Bool
) AS
SELECT
 s.invoice_id,
 s.invoice_date,
 multiIf(s.voided = true, \'Voided\', s.approved = true, multiIf(s.overdue = true, \'Overdue\', s.due = true, \'Due\', s.paid = true, \'Paid\', \'Approved\'), \'Pending\') AS name,
 ifNull(toBool(s.approved), false) AS approved,
 ifNull(toBool(s.paid), false) AS paid,
 ifNull(toBool(s.overdue), false) AS overdue,
 ifNull(toBool(s.voided), false) AS voided,
 ifNull(toBool(s.due), false) AS due
FROM
(
 SELECT
 i.invoice_id AS invoice_id,
 i.invoice_date AS invoice_date,
 i.void_time IS NOT NULL AS voided,
 (i.void_time IS NULL) AND (i.approved_time IS NOT NULL) AS approved,
 (i.void_time IS NULL) AND (i.approved_time IS NOT NULL) AND (i.sent_time IS NOT NULL) AND (((sum(i.amount) + sum(coalesce(p.amount, CAST(0, \'Decimal(12, 2)\')))) + sum(coalesce(c.amount, CAST(0, \'Decimal(12, 2)\')))) > CAST(0, \'Decimal(12, 2)\')) AND (toDate(toDateTime(now())) <= toDate(addDays(i.sent_time, 30))) AS due,
 (i.void_time IS NULL) AND (i.approved_time IS NOT NULL) AND (((sum(i.amount) + sum(coalesce(p.amount, CAST(0, \'Decimal(12, 2)\')))) + sum(coalesce(c.amount, CAST(0, \'Decimal(12, 2)\')))) <= CAST(0, \'Decimal(12, 2)\')) AS paid,
 (i.void_time IS NULL) AND (i.approved_time IS NOT NULL) AND (((sum(i.amount) + sum(coalesce(p.amount, CAST(0, \'Decimal(12, 2)\')))) + sum(coalesce(c.amount, CAST(0, \'Decimal(12, 2)\')))) > CAST(0, \'Decimal(12, 2)\')) AND (toDate(toDateTime(now())) > toDate(addDays(i.sent_time, 30))) AS overdue
 FROM invoice.raw_invoices AS i
 LEFT JOIN
 (
 SELECT
 payments.invoice_id,
 sum(payments.amount) AS amount
 FROM invoice.payments
 GROUP BY payments.invoice_id
 ) AS p USING (invoice_id)
 LEFT JOIN
 (
 SELECT
 credits.invoice_id,
 sum(credits.amount) AS amount
 FROM invoice.credits
 WHERE credits.credit_status_id = 2
 GROUP BY credits.invoice_id
 ) AS c ON i.invoice_id = c.invoice_id
 LEFT JOIN info.advertisers AS a ON i.advertiser_id = a.advertiser_id
 WHERE i.invoice_id = 308980
 GROUP BY
 i.invoice_id,
 i.invoice_date,
 i.void_time,
 i.approved_time,
 i.due_date,
 a.time_zone,
 i.sent_time
) AS s
