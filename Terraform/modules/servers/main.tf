resource "hcloud_server" "clickhouse" {
  count = 3
  name         = "clickhouse-${count.index}"
  image        = var.image_name
  server_type  = "cx21"
  ssh_keys = [data.hcloud_ssh_key.key1.id,data.hcloud_ssh_key.key2.id,data.hcloud_ssh_key.key3.id]
  location = var.location
}


resource "hcloud_server" "monitoring" {
  count = 2
  name         = "monitoring-${count.index}"
  image        = var.image_name
  server_type  = "cx21"
  ssh_keys = [data.hcloud_ssh_key.key1.id,data.hcloud_ssh_key.key2.id,data.hcloud_ssh_key.key3.id]
  location = var.location
}




data "hcloud_ssh_key" "key1"  {
  name = "kang"

}

data "hcloud_ssh_key" "key2"  {
  name = "Kangkey"
}

data "hcloud_ssh_key" "key3" {
  name = "ssh_key_bastion"
}


resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      clickhouse_ips = hcloud_server.clickhouse.*.ipv4_address
      monitoring_ips = hcloud_server.monitoring.*.ipv4_address
    }
  )
  filename = "${path.module}/../../../Ansible/inventory/inventory.yaml"
}


resource "local_file" "etcd-hosts" {
  content  = templatefile("${path.module}/etchost.tpl",
    {
      clickhouse_ips = hcloud_server.clickhouse.*.ipv4_address
      monitoring_ips = hcloud_server.monitoring.*.ipv4_address
    }
  )
  filename = "${path.module}/../../../Ansible/roles/general/files/etchost.yaml"
}







