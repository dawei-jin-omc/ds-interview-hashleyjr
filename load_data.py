import sqlite3
import pandas as pd
from pathlib import Path

DB_PATH = "/home/interview/interview.db"
DATA_DIR = Path("/build/data")

conn = sqlite3.connect(DB_PATH)

# Each CSV becomes a table named after the file (sales.csv -> "sales")
for csv_file in DATA_DIR.glob("*.csv"):
    table_name = csv_file.stem
    df = pd.read_csv(csv_file)
    df.to_sql(table_name, conn, if_exists="replace", index=False)
    print(f"Loaded {len(df)} rows into table '{table_name}'")

conn.close()
print(f"Database written to {DB_PATH}")