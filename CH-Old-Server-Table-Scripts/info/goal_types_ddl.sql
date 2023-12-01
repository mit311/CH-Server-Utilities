CREATE TABLE info.goal_types
(
 `goal_type_id` Int32,
 `name` Nullable(String),
 `description` Nullable(String)
)
ENGINE = MergeTree
ORDER BY goal_type_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
