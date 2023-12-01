#!/bin/bash

# Define ClickHouse connection parameters
CLICKHOUSE_HOST="10.4.34.182"
CLICKHOUSE_PORT="9000"
CLICKHOUSE_USER="r2ds"
CLICKHOUSE_PASSWORD="l4NyQ10zTZoFIbKNYDsdRoy6IHruojPe"
DATABASE_NAME="info"

# Output directory
OUTPUT_DIR="CH-Old-Server-Table-Scripts/"$DATABASE_NAME

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Command to get all views from the specified database
GET_VIEWS_QUERY="SELECT name FROM system.tables WHERE database = '$DATABASE_NAME' AND engine = 'MergeTree';"

# Execute the query and store the list of views
TABLES=$(~/./clickhouse client --host=$CLICKHOUSE_HOST --port=$CLICKHOUSE_PORT --user=$CLICKHOUSE_USER --password=$CLICKHOUSE_PASSWORD --query="$GET_VIEWS_QUERY")

# Loop through each view and get its DDL
for TABLE in $TABLES; do

    # Get the DDL for the current view
    DDL_QUERY="SHOW CREATE TABLE $DATABASE_NAME.$TABLE;"

     # Generate the output file path
    output_file="$OUTPUT_DIR/${TABLE}_ddl.sql"
    DDL_STATEMENT=$(clickhouse-client --host=$CLICKHOUSE_HOST --port=$CLICKHOUSE_PORT --user=$CLICKHOUSE_USER --password=$CLICKHOUSE_PASSWORD --query="$DDL_QUERY")
    echo $output_file
    echo -e ${DDL_STATEMENT} > $output_file

    # Output the DDL
    # echo "DDL for view $VIEW:"
    # echo "$DDL"
    # echo ""
done