CREATE TABLE info_test.campaign_groups
(
 `campaign_group_id` Int32,
 `advertiser_id` Int32 DEFAULT -1,
 `name` String DEFAULT \'\',
 `create_time` DateTime64(6) DEFAULT now64(),
 `update_time` DateTime64(6) DEFAULT now64(),
 `update_time_raw` DateTime64(6) DEFAULT now64(),
 `description` String DEFAULT \'\',
 `parent_campaign_group_id` Int32 DEFAULT -1,
 `start_time` DateTime64(6) DEFAULT now64(),
 `end_time` Nullable(DateTime64(6)),
 `budget` Decimal(12, 2) DEFAULT 0.,
 `budget_type_id` Int32 DEFAULT -1,
 `active_flight_id` Int32 DEFAULT -1,
 `deleted` UInt8 DEFAULT 0,
 `objective_id` Int32 DEFAULT -1,
 `goal_value` Decimal(12, 2) DEFAULT 0.,
 `goal_type_id` Int32 DEFAULT -1,
 `goal_type_name` String DEFAULT \'\',
 `budget_lock` UInt8 DEFAULT 0,
 `first_launch_time` Nullable(DateTime64(6)),
 `client_launch_status` String DEFAULT \'\',
 `extension_budget_split` Decimal(12, 2) DEFAULT 0.,
 `restricted_edits` UInt8 DEFAULT 0,
 `testing_type` String DEFAULT \'\',
 `is_test` UInt8 DEFAULT 0,
 `has_audience_raw` UInt8 DEFAULT 0,
 `has_audience` UInt8 DEFAULT 0,
 `ctv_creatives_status_id_raw` Int32 DEFAULT -1,
 `display_creatives_status_id_raw` Int32 DEFAULT -1,
 `campaign_group_status_id` Int32 DEFAULT -1,
 `campaign_group_status` String DEFAULT \'\',
 `ctv_creatives_status_id` Int32 DEFAULT -1,
 `display_creatives_status_id` Int32 DEFAULT -1,
 `click_url` String DEFAULT \'\',
 `frequency_cap_impressions` Int16 DEFAULT 0,
 `frequency_cap_duration` String DEFAULT \'\'
)
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
PRIMARY KEY campaign_group_id
ORDER BY campaign_group_id
SETTINGS index_granularity = 8192
