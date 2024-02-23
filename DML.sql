-- Script to create drop partition query for a CH (local) table
-- This script should be run on each shard nodes (replicas will drop partitions if run on one node, so no need to run on all replica nodes)

SELECT 'ALTER TABLE `'||database||'`.`'||table||'` DROP PART \''||name||'\';'
FROM system.parts
WHERE
database = 'summarydata' AND table = 'all_facts_local' and  partition = '202312'
format TSVRaw;


RENAME TABLE
summarydata.all_facts_local TO summarydata.all_facts_local1,
summarydata.all_facts TO summarydata.all_facts1
ON CLUSTER 'reporting-dev01';

