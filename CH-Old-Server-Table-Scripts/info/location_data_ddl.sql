CREATE TABLE info.location_data
(
 `location_id` Int32,
 `location_type_id` Int32,
 `geoname_id` Nullable(Int32),
 `location` String,
 `sub_location1` Nullable(String),
 `sub_location2` Nullable(String),
 `iso_code` Nullable(String),
 `time_zone` Nullable(String),
 `parent_location_id` Nullable(Int32),
 `old_location_id` Nullable(Int32),
 `metro_id` Nullable(Int32),
 `country_iso_code` Nullable(String)
)
ENGINE = MergeTree
ORDER BY location
SETTINGS index_granularity = 8192, allow_nullable_key = 1
