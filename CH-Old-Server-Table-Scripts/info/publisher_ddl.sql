CREATE TABLE info.publisher
(
 `publisher` Nullable(String)
)
ENGINE = MergeTree
ORDER BY publisher
SETTINGS index_granularity = 8192, allow_nullable_key = 1
