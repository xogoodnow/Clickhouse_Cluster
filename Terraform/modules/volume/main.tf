data "hcloud_server" "redis" {
  count = 3
  name = "redis-${count.index}"
}

resource "hcloud_volume" "osd_volumes" {
  count = length(data.hcloud_server.redis)
  name  = "redis-${count.index}-volume"
  size  = 250
  server_id = data.hcloud_server.redis[count.index].id
}