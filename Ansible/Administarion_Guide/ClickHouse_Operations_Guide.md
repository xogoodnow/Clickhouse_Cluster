
# ClickHouse Operations Guide

## Basic Operations

1. **Connect to ClickHouse**
   - Command: `clickhouse-client --host [hostname] --port [port] --user [username] --password [password]`
   - Example: `clickhouse-client --host localhost --port 9000 --user default --password myPassword`
   - Explanation: Establishes a connection to a ClickHouse server. Essential for performing any database operations.


2. **Show Databases**
   - Command: `SHOW DATABASES`
   - Explanation: Lists all databases available on the ClickHouse server. Useful for seeing the overall database structure.


3. **Create a New Database**
   - Command: `CREATE DATABASE myDatabase`
   - Explanation: Creates a new database. Fundamental for organizing data into logical groups.


4. **Use a Specific Database**
   - Command: `USE myDatabase`
   - Explanation: Selects a specific database for subsequent operations.


5. **Create a Table**
   - Command: `CREATE TABLE myTable (id UInt32, name String) ENGINE = MergeTree() ORDER BY id`
   - Explanation: Creates a new table with specified columns and data types. MergeTree is a common storage engine in ClickHouse.


6. **Insert Data into a Table**
   - Command: `INSERT INTO myTable (id, name) VALUES (1, 'John')`
   - Explanation: Adds new data to a table. Key for populating tables with data.

7. **Select Data from a Table**
   - Command: `SELECT * FROM myTable WHERE id = 1`
   - Explanation: Retrieves data from a table. Essential for data querying and retrieval.


8. **Update Data in a Table**
   - Command: `ALTER TABLE myTable UPDATE name = 'Jane' WHERE id = 1`
   - Explanation: Modifies existing data in a table. Important for maintaining up-to-date information.


9. **Delete Data from a Table**
   - Command: `ALTER TABLE myTable DELETE WHERE id = 1`
   - Explanation: Removes data from a table. Used for data management and cleanup.


10. **Drop a Table**
    - Command: `DROP TABLE myTable`
    - Explanation: Deletes a table and all its data. Useful for removing obsolete or unnecessary data structures.



## Intermediate Operations

11. **Create a Materialized View**
    - Command: `CREATE MATERIALIZED VIEW myView ENGINE = MergeTree() ORDER BY id AS SELECT * FROM myTable`
    - Explanation: Creates a materialized view for efficient query processing. Useful for optimizing read-heavy workloads.


12. **Optimize Table**
    - Command: `OPTIMIZE TABLE myTable FINAL`
    - Explanation: Merges data parts in a table to optimize storage and improve query performance.


13. **Backup a Table (Data Dump)**
    - Command: `clickhouse-client --query="SELECT * FROM myTable FORMAT TSV" > myTable_backup.tsv`
    - Explanation: Exports data from a table into a file. Essential for data backup and migration.


14. **Restore a Table (Data Load)**
    - Command: `clickhouse-client --query="INSERT INTO myTable FORMAT TSV" < myTable_backup.tsv`
    - Explanation: Imports data from a file into a table. Key for data restoration and migration.


15. **Managing Partitions**
    - Command: `ALTER TABLE myTable DROP PARTITION '2020-01'`
    - Explanation: Manages table partitions, such as dropping old or unnecessary partitions. Important for data lifecycle management.


16. **Column Compression**
    - Command: `ALTER TABLE myTable MODIFY COLUMN myColumn UInt32 CODEC(ZSTD)`
    - Explanation: Applies compression to a column to reduce storage space. Useful for optimizing storage efficiency.


17. **MergeTree Table Engine**
    - Command: `CREATE TABLE myMergeTree (date Date, name String) ENGINE = MergeTree(date, (date), 8192)`
    - Explanation: Creates a table with the MergeTree engine, optimized for analytical queries over large datasets.


18. **Create a Dictionary**
    - Command: `CREATE DICTIONARY myDictionary (id UInt32, name String) PRIMARY KEY id SOURCE(CLICKHOUSE(HOST 'localhost' PORT 9000 USER 'default' TABLE 'myTable' PASSWORD 'password')) LAYOUT(FLAT()) LIFETIME(MIN 300 MAX 3600)`
    - Explanation: Defines a dictionary for efficient data lookups. Enhances performance for queries involving reference data.


19. **View Table Structure**
    - Command: `DESCRIBE TABLE myTable`
    - Explanation: Displays the structure (columns and types) of a table. Helpful for understanding and verifying table schema.


20. **Monitoring Queries**
    - Command: `SELECT * FROM system.processes`
    - Explanation: Lists current queries and processes running on the ClickHouse server. Useful for monitoring and troubleshooting.


## Advanced Operations

21. **Join Tables**
    - Command: `SELECT * FROM myTable1 ANY INNER JOIN myTable2 USING id`


22. **Cluster Setup and Management**
    - Command: `CREATE TABLE myCluster (id UInt32, name String) ENGINE = ReplicatedMergeTree('/clickhouse/myCluster/tables/{shard}/myTable', '{replica}') ORDER BY id`


23. **Columnar Storage**
    - Command: `CREATE TABLE myColumnar (id UInt32, name String) ENGINE = Columnar()`


24. **Data Sampling**
    - Command: `SELECT * FROM myTable SAMPLE 0.1`


25. **Time Series Data Aggregation**
    - Command: `SELECT toStartOfHour(time) AS hour, avg(value) FROM myTimeSeries GROUP BY hour`


26. **Geospatial Data Handling**
    - Command: `SELECT * FROM myGeoTable WHERE geoDistance(lon, lat, 37.6173, 55.7558) < 10000`


27. **Nested Data Types**
    - Command: `CREATE TABLE myNested (name String, attributes Nested(key String, value String)) ENGINE = MergeTree() ORDER BY name`


28. **Data Replication**
    - Command: `CREATE TABLE myReplica (id UInt32, name String) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{shard}/myReplica', '{replica}') ORDER BY id`


29. **Distributed Query Processing**
    - Command: `SELECT * FROM myDistributed WHERE id = 1`


30. **Handling Large Arrays**
    - Command: `SELECT arrayJoin(myArray) AS item FROM myArrayTable WHERE has(myArray, 'desiredValue')`
