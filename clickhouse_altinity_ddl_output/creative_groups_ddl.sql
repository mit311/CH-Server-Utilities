CREATE TABLE info_test.creative_groups
(
 `group_id` Int32,
 `campaign_id` Int32,
 `name` String,
 `click_url` String DEFAULT \'\',
 `weight` Int32,
 `imp_limit_day` Int32 DEFAULT 0,
 `imp_limit_user_day` Int32 DEFAULT 0,
 `active` UInt8,
 `escalating_order` Int32 DEFAULT 0,
 `escalation_type_id` Int16 DEFAULT 0,
 `escalation_limit` Int16 DEFAULT 0,
 `control_percentage` Int32,
 `is_control` UInt8 DEFAULT 0,
 `url_prefix` String DEFAULT \'\',
 `url_suffix` String DEFAULT \'\',
 `dpp_id` String DEFAULT \'\',
 `impression_tracking` String DEFAULT \'\',
 `mycreative_group_id` Int32 DEFAULT 0,
 `template_group_id` Int32 DEFAULT 0,
 `snapshot` String DEFAULT \'\',
 `update_time` DateTime64(6) DEFAULT now64(),
 `create_time` DateTime64(6) DEFAULT now64(),
 `description` String DEFAULT \'\',
 `dpp_filter` String DEFAULT \'\',
 `display_url` String DEFAULT \'\',
 `parent_group_id` Int32 DEFAULT 0,
 `ordinal` Int32 DEFAULT 0,
 `user_id` Int32 DEFAULT 0,
 `mycreative_video_group_id` Int32 DEFAULT 0,
 `has_dynamic` UInt8 DEFAULT 0
)
ENGINE = ReplicatedMergeTree(\'/clickhouse/{cluster}/tables/info_test/{uuid}/\', \'{replica}\')
ORDER BY group_id
SETTINGS index_granularity = 8192
