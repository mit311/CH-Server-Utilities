CREATE TABLE info.budget_types
(
 `budget_type_id` Int32,
 `name` String
)
ENGINE = MergeTree
ORDER BY budget_type_id
SETTINGS index_granularity = 8192, allow_nullable_key = 1
