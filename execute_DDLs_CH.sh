#!/bin/bash

# Define ClickHouse connection parameters

CLICKHOUSE_HOST="reporting-dev01.mountain-altinity.altinity.cloud"
CLICKHOUSE_PORT="9440"
CLICKHOUSE_USER="admin"
CLICKHOUSE_PASSWORD="St33lh0use#Dev"



# Directory containing DDL scripts
# DDL_DIRECTORY="./clickhouse_ddl_output"
DDL_DIRECTORY="../clickhouse_ddl_output"


# Iterate over each .sql file in the directory
for FILE in "$DDL_DIRECTORY"/*.sql; do
    echo "Processing $FILE file..."

    # Read the content of the DDL file
    DDL_CONTENT=$(<"$FILE")

    # Execute the DDL content on the ClickHouse server
    clickhouse-client --host=$CLICKHOUSE_HOST --secure --port=$CLICKHOUSE_PORT --user=$CLICKHOUSE_USER --password=$CLICKHOUSE_PASSWORD --multiquery --query="$DDL_CONTENT"

    echo "$FILE executed successfully."
done







