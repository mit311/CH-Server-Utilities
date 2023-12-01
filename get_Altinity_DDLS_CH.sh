#!/bin/bash

# Define ClickHouse connection parameters
# CLICKHOUSE_HOST="10.4.34.182"
# CLICKHOUSE_PORT="9000"
# CLICKHOUSE_USER="r2ds"
# CLICKHOUSE_PASSWORD="l4NyQ10zTZoFIbKNYDsdRoy6IHruojPe"
# DATABASE_NAME="invoice"

CLICKHOUSE_HOST="reporting-dev01.mountain-altinity.altinity.cloud"
CLICKHOUSE_PORT="9440"
CLICKHOUSE_USER="admin"
CLICKHOUSE_PASSWORD="St33lh0use#Dev"
DATABASE_NAME="info_test"

# Output directory
OUTPUT_DIR="clickhouse_altinity_ddl_output"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Command to get all views from the specified database
GET_VIEWS_QUERY="SELECT name FROM system.tables WHERE database = '$DATABASE_NAME' AND engine = 'ReplicatedMergeTree';"

# Execute the query and store the list of views
# VIEWS=$(~/./clickhouse client --host=$CLICKHOUSE_HOST --port=$CLICKHOUSE_PORT --user=$CLICKHOUSE_USER --password=$CLICKHOUSE_PASSWORD --query="$GET_VIEWS_QUERY")

VIEWS=$(clickhouse-client client --host=$CLICKHOUSE_HOST --secure --port=$CLICKHOUSE_PORT --user=$CLICKHOUSE_USER --password=$CLICKHOUSE_PASSWORD --query="$GET_VIEWS_QUERY")

# Loop through each view and get its DDL
for VIEW in $VIEWS; do

    echo $VIEW
    # Get the DDL for the current view
    DDL_QUERY="SHOW CREATE TABLE $DATABASE_NAME.$VIEW;"

     # Generate the output file path
    output_file="$OUTPUT_DIR/${VIEW}_ddl.sql"
    DDL_STATEMENT=$(clickhouse-client --host=$CLICKHOUSE_HOST --secure --port=$CLICKHOUSE_PORT --user=$CLICKHOUSE_USER --password=$CLICKHOUSE_PASSWORD --query="$DDL_QUERY")
    echo -e ${DDL_STATEMENT} > $output_file

    # Output the DDLß
    # echo "DDL for view $VIEW:"
    # echo "$DDL"
    # echo ""
done