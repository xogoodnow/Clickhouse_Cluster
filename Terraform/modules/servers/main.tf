resource "hcloud_server" "clickhouse" {
  count       = var.shard_count
  name        = "clickhouse-${count.index}"
  image       = var.image_name
  server_type = var.server_type
  ssh_keys    = var.ssh_key_ids
  location    = var.location
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      clickhouse_ips = hcloud_server.clickhouse.*.ipv4_address
      monitoring_ips = []
    }
  )
  filename = "${var.ansible_path}/inventory/inventory.yaml"
}


resource "local_file" "etcd-hosts" {
  content = templatefile("${path.module}/etchost.tpl",
    {
      clickhouse_ips = hcloud_server.clickhouse.*.ipv4_address
      monitoring_ips = []
    }
  )
  filename = "${var.ansible_path}/roles/general/files/etchost.yaml"
}
