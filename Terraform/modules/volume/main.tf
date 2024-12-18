data "hcloud_server" "clickhouse" {
  count = var.shard_count
  name  = "clickhouse-${count.index}"
}

resource "hcloud_volume" "clickhouse_volumes" {
  count     = length(data.hcloud_server.clickhouse)
  name      = "clickhouse-${count.index}-volume"
  size      = var.volume_size
  server_id = data.hcloud_server.clickhouse[count.index].id
}
