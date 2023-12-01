CREATE TABLE summarydata.impression_facts_single_final
(
 `hour` DateTime,
 `advertiser_id` Int32,
 `campaign_group_id` Int32,
 `campaign_id` Int32,
 `channel_id` Int32,
 `objective_id` Int32,
 `group_id` Int32,
 `creative_id` Int32,
 `private_marketplace_id` Nullable(String),
 `country` Nullable(String),
 `metro_id` Int32,
 `region` Nullable(String),
 `city` Nullable(String),
 `postal_code` Nullable(String),
 `domain` Nullable(String),
 `uniques` AggregateFunction(uniqCombined, Nullable(String)),
 `existing_users_reached` AggregateFunction(uniqCombined, Nullable(String)),
 `new_users_reached` AggregateFunction(uniqCombined, Nullable(String))
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(hour)
ORDER BY (advertiser_id, hour)
SETTINGS index_granularity = 8192
