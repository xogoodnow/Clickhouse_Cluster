#!/bin/bash

# List of ClickHouse nodes
nodes=("clickhouse-0" "clickhouse-1" "clickhouse-2")

# Username and password
username="username"
password="password"

# SQL query
query="SELECT Year, Variable_name, SUM(toFloat64(replaceAll(Value, ',', ''))) as TotalValue FROM kang.industry_data_distributed WHERE Industry_name_NZSIOC = 'All industries' GROUP BY Year, Variable_name ORDER BY TotalValue DESC;"

# Save the query to a file
echo "$query" > query.sql

# Number of iterations and concurrency
iterations=10
concurrency=10
delay=1
confidence=0.95

# Loop over each node
for node in "${nodes[@]}"
do
  echo "Benchmarking node: $node"

  # Run benchmark
  clickhouse-benchmark -i $iterations -c $concurrency --delay $delay --confidence $confidence --host=$node --user=$username --password=$password < query.sql
done

# Remove the query file
rm query.sql
