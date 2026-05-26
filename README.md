# SQL Market Data Project

This project loads, cleans, transforms, and analyzes market data using PostgreSQL.  
All steps are automated through a shell script for easy re-running.

---

## Project Structure


project/
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_load_raw.sql
│   ├── 03_clean_transform.sql
│   └── 04_analysis_queries.sql
│
├── raw/                  # Raw CSV source files (LMP, uplift, etc.)
├── run_all.sh            # Runs all SQL scripts in order
├── run_all.bat           # Bat File for Windows Users
└── README.md

# Setup
1. Install PostgreSQL

Make sure psql is installed and available in your terminal.

You can verify with:

psql --version
2. Update Database Credentials

If needed, edit run_all.sh to use your PostgreSQL username and database name.

# Running the Project

From the project root directory:

chmod +x run_all.sh   # Only needed once
./run_all.sh

This executes the SQL files in the following order:

01_create_tables.sql — Creates all database tables
02_load_raw.sql — Loads raw CSV data
03_clean_transform.sql — Cleans and transforms data
04_analysis_queries.sql — Runs analysis queries
Output

Analysis results are printed directly to the terminal.

You can modify 04_analysis_queries.sql to add your own custom queries and analyses.
