#!/bin/bash

psql -U postgres -d postgres -f sql/01_create_tables.sql
psql -U postgres -d postgres -f sql/02_load_raw.sql
psql -U postgres -d postgres -f sql/03_clean_transform.sql
psql -U postgres -d postgres -f sql/04_analysis_queries.sql

echo "Done."
read -p "Press enter to continue..."