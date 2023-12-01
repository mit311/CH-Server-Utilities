CREATE TABLE info.creatives
(
 `creative_id` Int32,
 `creative_size_id` Int32,
 `advertiser_id` Int32,
 `name` Nullable(String),
 `media_type_id` Nullable(Int32),
 `creative_location` Nullable(String),
 `create_time` Nullable(DateTime64(6)),
 `active` UInt8,
 `approved` Nullable(UInt8),
 `update_time` Nullable(DateTime64(6)),
 `adcode` Nullable(String),
 `adserver_payload` Nullable(String),
 `is_adcode` UInt8,
 `is_control_creative` Nullable(UInt8),
 `fb_headline` Nullable(String),
 `fb_text` Nullable(String),
 `fb_description` Nullable(String),
 `fb_social` Nullable(UInt8),
 `a2_version` Nullable(Int32),
 `fb_cta` Nullable(String),
 `adbuilder_compatible` Nullable(UInt8),
 `static_image_location` Nullable(String),
 `fb_display_url` Nullable(String),
 `deleted` UInt8,
 `fb_click_url` Nullable(String),
 `fb_url_prefix` Nullable(String),
 `fb_url_suffix` Nullable(String),
 `user_id` Nullable(Int32)
)
ENGINE = MergeTree
ORDER BY creative_id
SETTINGS allow_nullable_key = 1, index_granularity = 8192
