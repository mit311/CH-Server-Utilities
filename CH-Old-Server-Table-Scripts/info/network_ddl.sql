CREATE TABLE info.network
(
 `network` Nullable(String)
)
ENGINE = MergeTree
ORDER BY network
SETTINGS index_granularity = 8192, allow_nullable_key = 1
