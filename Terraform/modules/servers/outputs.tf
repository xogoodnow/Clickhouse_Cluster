output "clickhouse_ips" {
  value = hcloud_server.clickhouse[*].ipv4_address
}

output "monitoring_ips" {
  value = hcloud_server.monitoring[*].ipv4_address
}


