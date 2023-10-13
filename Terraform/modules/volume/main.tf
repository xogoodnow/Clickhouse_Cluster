data "hcloud_server" "clickhouse" {
  count = 3
  name = "clickhouse-${count.index}"
}

resource "hcloud_volume" "clickhouse_volumes" {
  count = length(data.hcloud_server.clickhouse)
  name  = "clickhouse-${count.index}-volume"
  size  = 250
  server_id = data.hcloud_server.clickhouse[count.index].id
}