CREATE VIEW info.region_info
(
 `region` String,
 `country` Nullable(String),
 `iso_code` Nullable(String),
 `country_iso_code` Nullable(String)
) AS
SELECT
 r.location AS region,
 r.sub_location1 AS country,
 r.iso_code,
 c.iso_code AS country_iso_code
FROM info.location_data AS r
INNER JOIN info.location_data AS c ON r.sub_location1 = c.location
WHERE (r.location_type_id = 5) AND (c.location_type_id = 2)
