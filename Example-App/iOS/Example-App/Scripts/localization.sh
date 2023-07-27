#!/bin/bash

# Source the .env file to get the environment variables. Update the path
source ./.env

# JSON file path
JSON_FILE="./lingua_config.json"

# Backup original JSON file
cp $JSON_FILE "$JSON_FILE.bak"

# Update GOOGLE_API_KEY
sed -i '' "s|<google_api_key>|${GOOGLE_API_KEY}|g" $JSON_FILE

# Update GOOGLE_SPREADSHEET_ID
sed -i '' "s|<google_spreadsheet_id>|${GOOGLE_SPREADSHEET_ID}|g" $JSON_FILE

# Run the lingua command for `ios` or `android`
lingua ios ./lingua_config.json

# Restore the original JSON file
mv "$JSON_FILE.bak" $JSON_FILE
