create table if not exists summarydata.all_facts_by_day_agg
(
    day                                  Date,
    advertiser_id                        Int32,
    campaign_group_id                    Int32          default 0,
    campaign_id                          Int32          default 0,
    channel_id                           Int32          default 0,
    objective_id                         Int32          default 0,
    group_id                             Int32          default 0,
    creative_id                          Int32          default 0,
    private_marketplace_id               String         default '',
    supply_vendor                        String         default '',
    device_type                          String         default '',
    country LowCardinality(String)                      default '',
    metro_id                             Int32          default 0,
    region LowCardinality(String)                       default '',
    city LowCardinality(String)                         default '',
    postal_code LowCardinality(String)                  default '',
    domain                               String         default '',
    display_impressions                  Int32          default 0,
    ctv_impressions                      Int32          default 0,
    media_cost                           Decimal(18, 9) default 0.,
    fee_cost                             Decimal(18, 9) default 0.,
    partner_cost                         Decimal(18, 9) default 0.,
    data_cost                            Decimal(18, 9) default 0.,
    media_spend                          Decimal(18, 9) default 0.,
    data_spend                           Decimal(18, 9) default 0.,
    platform_spend                       Decimal(18, 9) default 0.,
    legacy_spend                         Decimal(18, 9) default 0.,
    ctv_spend                            Decimal(18, 9) default 0.,
    views                                Int32          default 0,
    clicks                               Int32          default 0,
    view_conversions                     Int32          default 0,
    click_conversions                    Int32          default 0,
    view_order_value                     Decimal(18, 9) default 0.,
    click_order_value                    Decimal(18, 9) default 0.,
    view_impression                      Int32          default 0,
    view_viewed                          Int32          default 0,
    view_untrackable                     Int32          default 0,
    vast_start                           Int32          default 0,
    vast_firstquartile                   Int32          default 0,
    vast_midpoint                        Int32          default 0,
    vast_thirdquartile                   Int32          default 0,
    vast_complete                        Int32          default 0,
    uniques_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    unlinked_spend                       Decimal(18, 9) default 0.,
    bids                                 Int32          default 0,
    new_visitors                         Int32          default 0,
    raw_existing_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    raw_new_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    existing_users_reached_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    new_users_reached_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    existing_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    new_site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    site_visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    new_to_file                          Int32          default 0,
    raw_visits                           Int32          default 0,
    raw_conversions                      Int32          default 0,
    visitors_arr AggregateFunction(uniqArrayState, Array(Nullable(String))),
    raw_order_value                      Int32          default 0,
    first_touch_visits                   Int32          default 0,
    last_tv_touch_clicks                 Int32          default 0,
    last_tv_touch_views                  Int32          default 0,
    last_tv_touch_click_conversions      Int32          default 0,
    last_tv_touch_view_conversions       Int32          default 0,
    last_tv_touch_click_order_value      Decimal(18, 9) default 0.,
    last_tv_touch_view_order_value       Decimal(18, 9) default 0.,
    last_touch_clicks                    Int32          default 0,
    last_touch_views                     Int32          default 0,
    last_touch_click_conversions         Int32          default 0,
    last_touch_click_order_value         Decimal(18, 9) default 0.,
    last_touch_view_order_value          Decimal(18, 9) default 0.,
    visits_assist                        Int32          default 0,
    conversions_assist_click             Int32          default 0,
    conversions_assist_view              Int32          default 0,
    conversions_assist_click_order_value Decimal(18, 9) default 0.,
    conversions_assist_view_order_value  Decimal(18, 9) default 0.,
    last_touch_view_conversions          Int32          default 0
)
    engine = Distributed('reporting-dev01', 'summarydata', 'all_facts_local_by_day_agg',
             cityHash64(advertiser_id, postal_code))
        COMMENT 'Distributed  all_facts_by_day_agg table over all_facts_local_by_day_agg' comment 'Distributed  all_facts_by_day_agg table over all_facts_local_by_day_agg';



create table if not exists summarydata.all_facts_by_day_aggregated ON CLUSTER 'reporting-dev01' AS summarydata.all_facts_local_by_day_aggregated
    engine = Distributed('reporting-dev01', 'summarydata', 'all_facts_local_by_day_aggregated',
             cityHash64(advertiser_id, postal_code))
        COMMENT 'Distributed all_facts_local_by_day_aggregated table over all_facts_local_by_day_aggregated';

select day, count(*)
from summarydata.all_facts_by_day_aggregated
group by 1
order by 1;

select day, count(*)
from summarydata.all_facts_by_day
WHERE (day >= '2024-02-24')
  AND (day < '2024-02-27')
group by 1
order by 1
;

2024-02-24	42239939
2024-02-25	33220744
2024-02-26	37970062
2024-02-27	15393115

WITH weekly AS
         (SELECT toDate(hour) AS day,
                 count()      AS cnt
          FROM summarydata.all_facts_daily
          WHERE (hour >= '2024-02-24')
            AND (hour < '2024-02-27')
          GROUP BY day,
                   advertiser_id,
                   campaign_group_id,
                   campaign_id,
                   channel_id,
                   objective_id,
                   group_id,
                   creative_id,
                   country,
                   metro_id,
                   region,
                   city,
                   postal_code,
                   domain,
                   private_marketplace_id,
                   supply_vendor,
                   device_type)
SELECT day,
       count(*)
FROM weekly
GROUP BY 1
ORDER BY 1 ASC;


| 2024-02-24
│ 36754271
│
│ 2024-02-25
│ 33134293
│
│ 2024-02-26
│ 33957352
│
│ 2024-02-27
│ 17555898


    2024-02-24
│ 36 754 271
│ 48 062 953
│
│ 2024-02-25
│ 33 134 293
│ 41 779 600
│
│ 2024-02-26
│ 33957352
│ 43107403
│
│ 2024-02-27
│ 17555898
│ 2154301

select 36754271 * .30 + 36754271


           -- 1) API changes -->
-- 2) Inserting daily --> populate -->  size
-- 3) -- Daily --> populate -->


-- Goal --> one materialized view and one aggregated table ->

--  API changes
--- Backill one month
-- test couple reports
-- remove unwanted MV's
-- Backfill november --> script
-- Test
-- Historical Backfill


---> vv visit --->  impression time

---> sum btw two summary tables -->

--> more update --> {cohort facts } { }

--> Cohort --> cohort facts in CoreDW ?  -->
--> CoreDW --> GC --> Flink


           select partition, formatReadableSize(sum(bytes_on_disk))
from cluster('reporting-dev01', system.parts)
where database = 'summarydata'
  and table like '%all_facts_local_daily'
  and partition in (20240224, 20240225, 20240226)
group by partition
order by partition FORMAT Vertical;


select partition, formatReadableSize(sum(bytes_on_disk))
from cluster('reporting-dev01', system.parts)
where database = 'summarydata'
  and table like '%all_facts_local_by_day'
  and partition in (20240224, 20240225, 20240226)
group by partition
order by partition FORMAT Vertical;


select partition, formatReadableSize(sum(bytes_on_disk))
from cluster('reporting-dev01', system.parts)
where database = 'summarydata'
  and table like '%all_facts_local_by_day_aggregated'
  and partition in (20240224, 20240225, 20240226)
group by partition
order by partition FORMAT Vertical;


WITH toStartOfDay(toDate('2023-11-01 00:00:00')) AS start, toStartOfDay(toDate('2023-12-01 00:00:00')) AS end,
    dates AS (SELECT arrayJoin(arrayMap(x -> toDate(x), range(toUInt32(start), toUInt32(end), 86400))) as day),
    advertisers AS (SELECT advertiser_id FROM info.advertisers WHERE advertiser_id IN (32185)),
    t1 AS (select sum(ifNull(t1.ctv_impressions, 0))     as ctv_impressions,
                  sum(ifNull(t1.display_impressions, 0)) as display_impressions,
                  sum(ifNull(t1.display_impressions, 0)) as display_impressions,
                  sum(ifNull(t1.ctv_impressions, 0))     as ctv_impressions,
                  sum(ifNull(t1.ctv_spend, 0))           as ctv_spend,
                  sum(ifNull(t1.media_spend, 0))         as media_spend,
                  sum(ifNull(t1.data_spend, 0))          as data_spend,
                  sum(ifNull(t1.platform_spend, 0))      as platform_spend,
                  sum(ifNull(t1.legacy_spend, 0))        as legacy_spend,
                  sum(ifNull(t1.clicks, 0))              as clicks,
                  sum(ifNull(t1.views, 0))               as views,
                  uniqArrayMergeState(t1.uniques_arr)    as uniques_arr,
                  sum(ifNull(t1.click_conversions, 0))   as click_conversions,
                  sum(ifNull(t1.view_conversions, 0))    as view_conversions,
                  sum(ifNull(t1.click_order_value, 0))   as click_order_value,
                  sum(ifNull(t1.view_order_value, 0))    as view_order_value,
                  group_id
           from summarydata.all_facts_by_day as t1
           where advertiser_id IN (32185)
             and day >= timestamp '2023-11-01 00:00:00'
             and day < timestamp '2023-12-01 00:00:00'
           group by group_id),
    data AS (select coalesce(sum(ifNull(t1.ctv_impressions, 0)), 0)                                          as c156,
                    coalesce(sum(ifNull(t1.display_impressions, 0)), 0)                                      as c13,
                    coalesce(sum(ifNull(t1.display_impressions, 0)) + sum(ifNull(t1.ctv_impressions, 0)), 0) as c158,
                    coalesce(sum(ifNull(t1.ctv_spend, 0)), 0)                                                as c160,
                    coalesce(greatest(0.00, ((sum(ifNull(t1.media_spend, 0)) + sum(ifNull(t1.data_spend, 0)) +
                                              sum(ifNull(t1.platform_spend, 0)) + sum(ifNull(t1.legacy_spend, 0))) -
                                             sum(ifNull(t1.ctv_spend, 0)))), 0)                              as c37,
                    coalesce(sum(ifNull(t1.media_spend, 0)) + sum(ifNull(t1.data_spend, 0)) +
                             sum(ifNull(t1.platform_spend, 0)) + sum(ifNull(t1.legacy_spend, 0)), 0)         as c34,
                    coalesce(sum(ifNull(t1.clicks, 0)) + sum(ifNull(t1.views, 0)), 0)                        as c38,
                    coalesce(((sum(ifNull(t1.clicks, 0)) + sum(ifNull(t1.views, 0))) /
                              nullif(toInt64(uniqArrayMerge(t1.uniques_arr)), 0)), 0)                        as c41,
                    coalesce((sum(ifNull(t1.media_spend, 0)) + sum(ifNull(t1.data_spend, 0)) +
                              sum(ifNull(t1.platform_spend, 0)) + sum(ifNull(t1.legacy_spend, 0))) /
                             nullif((sum(ifNull(t1.clicks, 0)) + sum(ifNull(t1.views, 0))), 0), 0)           as c42,
                    coalesce(toInt64(uniqArrayMerge(t1.uniques_arr)), 0)                                     as c159,
                    coalesce(sum(ifNull(t1.click_conversions, 0)) + sum(ifNull(t1.view_conversions, 0)), 0)  as c19,
                    coalesce(sum(ifNull(t1.click_order_value, 0)) + sum(ifNull(t1.view_order_value, 0)), 0)  as c28,
                    coalesce(((sum(ifNull(t1.click_conversions, 0)) + sum(ifNull(t1.view_conversions, 0))) /
                              nullif((sum(ifNull(t1.clicks, 0)) + sum(ifNull(t1.views, 0))), 0)), 0)         as c23,
                    coalesce((sum(ifNull(t1.click_order_value, 0)) + sum(ifNull(t1.view_order_value, 0))) /
                             nullif((sum(ifNull(t1.click_conversions, 0)) + sum(ifNull(t1.view_conversions, 0))), 0),
                             0)                                                                              as c18,
                    coalesce((sum(ifNull(t1.click_order_value, 0)) + sum(ifNull(t1.view_order_value, 0))) / nullif(
                            (sum(ifNull(t1.media_spend, 0)) + sum(ifNull(t1.data_spend, 0)) +
                             sum(ifNull(t1.platform_spend, 0)) + sum(ifNull(t1.legacy_spend, 0))), 0), 0)    as c29,
                    coalesce((sum(ifNull(t1.media_spend, 0)) + sum(ifNull(t1.data_spend, 0)) +
                              sum(ifNull(t1.platform_spend, 0)) + sum(ifNull(t1.legacy_spend, 0))) /
                             nullif((sum(ifNull(t1.click_conversions, 0)) + sum(ifNull(t1.view_conversions, 0))), 0),
                             0)                                                                              as c24,
                    t15.name                                                                                 as c284
             from t1
                      left join info.creative_groups t15 on t1.group_id = t15.group_id
             where c284 is not null
             group by c284),
    ttemp AS (select advertiser_id from (select distinct advertiser_id from advertisers) advertisers)
select coalesce(c156, 0) as c156,
       coalesce(c13, 0)  as c13,
       coalesce(c158, 0) as c158,
       coalesce(c160, 0) as c160,
       coalesce(c37, 0)  as c37,
       coalesce(c34, 0)  as c34,
       coalesce(c38, 0)  as c38,
       coalesce(c41, 0)  as c41,
       coalesce(c42, 0)  as c42,
       coalesce(c159, 0) as c159,
       coalesce(c19, 0)  as c19,
       coalesce(c28, 0)  as c28,
       coalesce(c23, 0)  as c23,
       coalesce(c18, 0)  as c18,
       coalesce(c29, 0)  as c29,
       coalesce(c24, 0)  as c24,
       c284              as c284
from data
order by c284 Asc
limit 51
SETTINGS
max_threads = 2
,
use_query_cache = 'true'
,
query_cache_store_results_of_queries_with_nondeterministic_functions = 1
,
query_cache_share_between_users = 1
,
query_cache_ttl = 300;


WITH toStartOfDay(toDate('2023-11-01 00:00:00')) AS start, toStartOfDay(toDate('2023-12-01 00:00:00')) AS end,
    dates AS (SELECT arrayJoin(arrayMap(x -> toDate(x), range(toUInt32(start), toUInt32(end), 86400))) as day),
    advertisers AS (SELECT advertiser_id FROM info.advertisers WHERE advertiser_id IN (32185)),
    t1 AS (select sum(ifNull(t1.display_impressions, 0)) as display_impressions,
                  sum(ifNull(t1.ctv_impressions, 0))     as ctv_impressions,
                  creative_id
           from summarydata.all_facts_by_day as t1
           where advertiser_id IN (32185)
             and day >= timestamp '2023-11-01 00:00:00'
             and day < timestamp '2023-12-01 00:00:00'
             and creative_id != 0
           group by creative_id),
    data AS (select coalesce(sum(ifNull(t1.display_impressions, 0)) + sum(ifNull(t1.ctv_impressions, 0)), 0) as c158,
                    toString(t18.width) || 'x' || toString(t18.height)                                       as c295
             from t1
                      left join info.creatives t17 on t1.creative_id = t17.creative_id
                      left join info.creative_sizes t18 on t17.creative_size_id = t18.creative_size_id
             where c295 is not null
               and c295 != ''
             group by c295),
    ttemp AS (select advertiser_id from (select distinct advertiser_id from advertisers) advertisers)
select coalesce(c158, 0) as c158, c295 as c295
from data
order by c295 Asc SETTINGS max_threads = 2, use_query_cache = 'true', query_cache_store_results_of_queries_with_nondeterministic_functions = 1, query_cache_share_between_users = 1, query_cache_ttl = 300


WITH toStartOfDay(toDate('2024-01-01 00:00:00')) AS start, toStartOfDay(toDate('2024-02-02 00:00:00')) AS end,
    dates AS (SELECT arrayJoin(arrayMap(x -> toDate(x), range(toUInt32(start), toUInt32(end), 86400))) as day),
    advertisers AS (SELECT advertiser_id FROM info.advertisers WHERE advertiser_id IN (32261)),
    t1 AS (select sum(ifNull(t1.click_conversions, 0)) as click_conversions,
                  sum(ifNull(t1.view_conversions, 0))  as view_conversions,
                  toDate(date_trunc('day', day))       as c140,
                  advertiser_id,
                  day,
                  advertiser_id
           from summarydata.all_facts_by_day as t1
           where advertiser_id IN (32261)
             and c140 >= timestamp '2024-01-01 00:00:00'
             and c140 < timestamp '2024-02-02 00:00:00'
           group by c140, advertiser_id, day, advertiser_id),
    data AS (select coalesce(t2.raw_conversions, 0)                                                         as c173,
                    coalesce(sum(ifNull(t1.click_conversions, 0)) + sum(ifNull(t1.view_conversions, 0)), 0) as c19,
                    t1.c140                                                                                 as c140,
                    t4.company_name                                                                         as c200
             from t1
                      left join info.v_advertisers t4 on t1.advertiser_id = t4.advertiser_id
                      left join test.all_facts_raw_metrics(advertiser_id = ?, begin_date = ?, end_date = ?) t2
                                on t1.day = t2.day and t1.advertiser_id = t2.advertiser_id
             where t1.advertiser_id != 0
               and t1.advertiser_id is not null
               and t1.day != 0
               and t1.day is not null
               and t1.advertiser_id != 0
               and t1.advertiser_id is not null
             group by c173, c140, c200),
    ttemp AS (select advertiser_id, day
              from (select distinct advertiser_id from advertisers) advertisers,
                   (select distinct day from dates) dates)
select c173 as c173, coalesce(c19, 0) as c19, ttemp.day as c140, c200 as c200
from ttemp
         left join data ON ttemp.day = data.c140
order by ttemp.day Asc, c200 Asc
limit 40
SETTINGS
max_threads = 2
,
use_query_cache = 'true'
,
query_cache_store_results_of_queries_with_nondeterministic_functions = 1
,
query_cache_share_between_users = 1
,
query_cache_ttl = 300;


select day, count(*) from summarydata.all_facts_local_by_day_aggregated group by 1 order by 1;

SELECT
    partition,
    formatReadableSize(sum(a.bytes_on_disk)) AS new_size,
    formatReadableSize(sum(b.bytes_on_disk)) AS size,
    count(a.name) AS new_total_parts,
    count(b.name) AS total_parts,
    sum(a.marks) AS new_total_marks,
    sum(b.marks) AS total_marks,
    formatReadableQuantity(sum(a.rows)) AS new_total_rows,
    formatReadableQuantity(sum(b.rows)) AS total_rows
FROM clusterAllReplicas('reporting-dev01', system.parts) AS a
INNER JOIN cluster('reporting-dev01', system.parts) AS b ON a.partition = b.partition
WHERE (a.database = 'summarydata') AND (a.table = 'all_facts_local_by_day_aggregated') AND (b.database = 'summarydata') AND (b.table = 'all_facts_local_by_day')
GROUP BY partition
ORDER BY 1 ASC;



select hour, * from summarydata.all_facts limit 1;


SELECT
    partition,
    formatReadableSize(sum(bytes_on_disk)) AS size,
    count(name) AS total_parts,
    sum(marks) AS total_marks,
    formatReadableQuantity(sum(rows)) AS total_rows
FROM cluster('reporting-dev01', system.parts) WHERE (database = 'summarydata') AND (table = 'all_facts_local_by_day') AND (partition >= '20240101') and (partition < '20240201') GROUP BY partition ORDER BY 1 ASC;

SELECT
    partition,
    formatReadableSize(sum(bytes_on_disk)) AS size,
    count(name) AS total_parts,
    sum(marks) AS total_marks,
    formatReadableQuantity(sum(rows)) AS total_rows
FROM cluster('reporting-dev01', system.parts) WHERE (database = 'summarydata') AND (table = 'all_facts_local_by_day_aggregated') AND (partition >= '20240101') and (partition < '20240201') GROUP BY partition ORDER BY 1 ASC;



OPTIMIZE TABLE summarydata.all_facts_local_by_day_aggregated ON CLUSTER 'reporting-dev01' PARTITION '20240101' FINAL
SETTINGS distributed_ddl_task_timeout=3600;


select max(hour) from summarydata.all_facts_daily;

select * from  (
    select advertiser_id, bar(count(*),0, max(count()) OVER()) AS dist from summarydata.all_facts_by_day where day >= '2024-01-01' and day < '2024-02-01' group by 1 order by dist desc
               ) where advertiser_id in (31276, 32185,31748);
;


select toDate(hour), count(*)
from summarydata.all_facts_daily  where hour >= '2024-02-26' and hour < '2024-03-03'
group by 1 order by 1 asc
