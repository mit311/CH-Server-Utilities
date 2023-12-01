#!/bin/bash

# Database connection parameters
DB_HOST="reportingdb-master.crvrygavls2u.us-west-2.rds.amazonaws.com"
DB_NAME="reportingdb"
DB_USER="read_only"

# Output directory
OUTPUT_DIR="ddl_output"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Prompt for the database password securely
read -s -p "Enter password for $DB_USER: " DB_PASSWORD
echo

# Loop through each table name passed as input
while IFS= read -r table_name; do
  # Generate the output file path
  output_file="$OUTPUT_DIR/${table_name}_ddl.sql"
  
  # Use pg_dump to retrieve DDL for the table
  PGPASSWORD="read_only" pg_dump --schema-only -t "$table_name" -h "$DB_HOST" -d "$DB_NAME" -U "$DB_USER" > "$output_file"
  
  echo "DDL for table '$table_name' saved to '$output_file'"
done

echo "DDL retrieval complete"