SELECT database,
       table,
       column,
       type,
       sum(rows)                                               AS rows,
       sum(column_data_compressed_bytes)                       AS compressed_bytes,
       formatReadableSize(compressed_bytes)                    AS compressed,
       formatReadableSize(sum(column_data_uncompressed_bytes)) AS uncompressed,
       sum(column_data_uncompressed_bytes) / compressed_bytes  AS ratio,
       any(compression_codec)                                  AS codec
FROM system.parts_columns AS pc
         LEFT JOIN system.columns AS c ON (pc.database = c.database) AND (c.table = pc.table) AND (c.name = pc.column)
WHERE (database LIKE 'test')
  AND active
GROUP BY database, table, column, type
ORDER BY database, table, sum(column_data_compressed_bytes) DESC;



SELECT replica_name,
       replica_path,
       total_replicas,
       active_replicas
FROM clusterAllReplicas('reporting-dev01', system.replicas)
WHERE table = 'all_facts_local_daily'
LIMIT 10
FORMAT
Vertical;



select partition, formatReadableSize(sum(bytes_on_disk))
from system.parts
where database = 'summarydata'
  and table like '%all_facts_local'
group by partition
order by partition FORMAT Vertical;


select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c)
from (
         select advertiser_id, count(distinct campaign_group_id) as c
         FROM summarydata.all_facts
         WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         group by advertiser_id
         order by c desc
         limit 100
         );

select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c)
from (
         select advertiser_id, count(distinct creative_id) as c
         FROM summarydata.all_facts
         WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         group by advertiser_id
         order by c desc
         limit 100
         );

select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c)
from (
         select advertiser_id, count(distinct group_id) as c
         FROM summarydata.all_facts
         WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         group by advertiser_id
         order by c desc
         limit 100
         );


select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c)
from (
         select advertiser_id, count(distinct group_id) as c
         FROM summarydata.all_facts
         WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         group by advertiser_id
         order by c desc
         limit 100
         );


select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c)
from (
         select advertiser_id, count(distinct group_id) as c
         FROM summarydata.all_facts
         WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         group by advertiser_id
         order by c desc
         limit 100
         );


select count()
from (
         select distinct domain
         FROM summarydata.all_facts
         WHERE advertiser_id = 31357
           and (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         );


select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c)
from (
         select advertiser_id, count(distinct domain) as c
         FROM summarydata.all_facts
         WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         group by advertiser_id
         order by c desc
         limit 100
         );


select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c)
from (
         select advertiser_id, count(distinct city) as c
         FROM summarydata.all_facts
         WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
           AND (hour < toDateTime('2023-11-31 00:00:00'))
         group by advertiser_id
         order by c desc
         limit 100
         );


with t as (SELECT advertiser_id,
                  count() AS c
           FROM summarydata.all_facts
           WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
             AND (hour < toDateTime('2023-11-31 00:00:00'))
           GROUP BY advertiser_id
           order by c asc)
select advertiser_id, c
from t
where c > 5000000
  and advertiser_id in (32407, 34611, 23146, 32023)
order by c desc;

select median(c), avg(c), quantilesExactExclusive(0.75, 0.8, 0.85, 0.9)(c) FROM (
    SELECT
        advertiser_id,
        count() AS c
FROM summarydata.all_facts
WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
AND (hour < toDateTime('2023-11-31 00:00:00'))
GROUP BY advertiser_id
);

SELECT
        advertiser_id,
        count() AS c
FROM summarydata.all_facts
WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
AND (hour < toDateTime('2023-11-31 00:00:00'))
GROUP BY advertiser_id
having count() > 469489 and count() <  1000000;


SELECT
        advertiser_id,
        count() AS c
FROM summarydata.all_facts
WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
AND (hour < toDateTime('2023-11-31 00:00:00'))
GROUP BY advertiser_id
having count() > 1000000
order by count() desc;

SELECT
        advertiser_id,
        count() AS c
FROM summarydata.all_facts
WHERE (hour >= toDateTime('2023-11-01 00:00:00'))
AND (hour < toDateTime('2023-11-31 00:00:00'))
GROUP BY advertiser_id
having count() >  154130 and count() <  469489;
