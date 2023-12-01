CREATE TABLE info.objectives
(
 `objective_id` Int32,
 `name` String,
 `description` Nullable(String)
)
ENGINE = MergeTree
ORDER BY objective_id
SETTINGS index_granularity = 8192
