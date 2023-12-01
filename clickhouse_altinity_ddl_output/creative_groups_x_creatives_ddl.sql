CREATE TABLE info_test.creative_groups_x_creatives
(
 `group_id` Int32,
 `creative_id` Int32,
 `click_url` String DEFAULT \'\',
 `active` UInt8,
 `url_prefix` String DEFAULT \'\',
 `url_suffix` String DEFAULT \'\',
 `dpp_id` String DEFAULT \'\',
 `impression_tracking` String DEFAULT \'\',
 `dpp_filter` String DEFAULT \'\',
 `user_id` Int32 DEFAULT 0
)
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
ORDER BY (group_id, creative_id)
SETTINGS index_granularity = 8192
