output "clickhouse_ips" {
  value = hcloud_server.clickhouse[*].ipv4_address
}
