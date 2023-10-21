#!/bin/bash

# Check if clickhouse-benchmark is installed
if ! command -v clickhouse-benchmark &> /dev/null
then
    echo "clickhouse-benchmark could not be found, installing..."
    sudo apt-get install -y apt-transport-https ca-certificates dirmngr
    GNUPGHOME=$(mktemp -d)
    sudo GNUPGHOME="$GNUPGHOME" gpg --no-default-keyring --keyring /usr/share/keyrings/clickhouse-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8919F6BD2B48D754
    sudo rm -r "$GNUPGHOME"
    sudo chmod +r /usr/share/keyrings/clickhouse-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/clickhouse-keyring.gpg] https://packages.clickhouse.com/deb stable main" | sudo tee \
        /etc/apt/sources.list.d/clickhouse.list
    sudo apt-get update
    sudo apt-get install -y clickhouse-client
fi

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
iterations=10000
concurrency=100
delay=1
confidence=5

# Loop over each node
for node in "${nodes[@]}"
do
  echo "Benchmarking node: $node"

  # Run benchmark
  clickhouse-benchmark -i $iterations -c $concurrency --delay $delay --confidence $confidence --host=$node --user=$username --password=$password < query.sql
done

# Remove the query file
rm query.sql
