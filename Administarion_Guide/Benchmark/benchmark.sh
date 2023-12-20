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
query="SELECT t1.Industry_name_NZSIOC, t1.Variable_name AS Variable1, t2.Variable_name AS Variable2, avg(toFloat32OrNull(replaceRegexpAll(t1.Value, ',', ''))) AS AvgValue1, avg(toFloat32OrNull(replaceRegexpAll(t2.Value, ',', ''))) AS AvgValue2, arrayJoin(splitByString(' ', t1.Industry_code_ANZSIC06)) AS SplitIndustryCode, rank() OVER (ORDER BY avg(toFloat32OrNull(replaceRegexpAll(t1.Value, ',', ''))) DESC) AS RankByValue1, rank() OVER (ORDER BY avg(toFloat32OrNull(replaceRegexpAll(t2.Value, ',', ''))) DESC) AS RankByValue2 FROM kang.kangtable AS t1 JOIN kang.kangtable AS t2 ON t1.Industry_name_NZSIOC = t2.Industry_name_NZSIOC WHERE t1.Year = 2021 AND t2.Year = 2021 AND t1.Variable_name = 'Total income' AND t2.Variable_name = 'Sales, government funding, grants and subsidies' GROUP BY t1.Industry_name_NZSIOC, t1.Variable_name, t2.Variable_name, arrayJoin(splitByString(' ', t1.Industry_code_ANZSIC06)) ORDER BY RankByValue1, RankByValue2 LIMIT 10;"

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