CREATE VIEW info.v_city
            (
             `city` String,
             `region` String,
             `country` Nullable(String),
             `parent_iso_code` Nullable(String),
             `name` Nullable(String)
                )
AS
WITH CTE AS
         (SELECT city.location       AS city,
                 state.location      AS region,
                 state.sub_location1 AS country,
                 state.iso_code      AS parent_iso_code
          FROM info.location_data AS city
                   INNER JOIN info.location_data AS state ON city.sub_location1 = state.location
          WHERE (city.location_type_id = 6)
            AND (state.location_type_id = 5))
SELECT city,
       region,
       country,
       parent_iso_code,
       multiIf(city = '-1', 'unknown', parent_iso_code IS NOT NULL, concat(city, ' ', parent_iso_code), city) AS name
FROM CTE;
