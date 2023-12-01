CREATE TABLE info.avg_imp_to_vv_time_by_parent_campaign_group
(
 `advertiser_id` Nullable(Int32),
 `campaign_group_id` Nullable(Int32),
 `day` Nullable(Date),
 `avg` Nullable(String)
)
ENGINE = MergeTree
ORDER BY (advertiser_id, campaign_group_id, day)
SETTINGS index_granularity = 8192, allow_nullable_key = 1
