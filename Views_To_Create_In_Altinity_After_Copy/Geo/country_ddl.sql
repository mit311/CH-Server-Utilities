CREATE VIEW info_test.country ON CLUSTER 'reporting-dev01'
(
 `country` String,
 `iso_code` String
) AS
SELECT
 c.location AS country,
 c.iso_code AS iso_code
FROM info_test.location_data AS c
WHERE c.location_type_id = 2;
