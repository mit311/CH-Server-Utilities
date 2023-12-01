CREATE TABLE info.InventoryType
(
 `type` String
)
ENGINE = MergeTree
ORDER BY type
SETTINGS index_granularity = 8192
