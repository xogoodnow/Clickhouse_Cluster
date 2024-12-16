module "ssh_keys" {
  source           = "./modules/ssh_keys"
  local_files_path = var.local_files_path
}


module "servers" {
  source       = "./modules/servers"
  hcloud_token = var.hcloud_token
  image_name   = var.image_name
  server_type  = var.server_type
  location     = var.location
  depends_on   = [module.ssh_keys]
}

module "volume" {
  source = "./modules/volume"
  hcloud_token = var.hcloud_token
  depends_on = [module.servers]
}


module "Clickhouse" {
  source = "./modules/Clickhouse"
  hcloud_token = var.hcloud_token
  depends_on = [module.volume]
}