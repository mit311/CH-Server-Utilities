CREATE VIEW summarydata.s3_cost_impression_log_replaced
(
 `replaceAll(line, \'\\\\"\', \'""\')` String
) AS
SELECT replaceAll(line, \'\\"\', \'""\')
FROM summarydata.s3_cost_impression_log_lines
