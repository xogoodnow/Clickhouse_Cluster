# Generate bastion ssh-key
resource "tls_private_key" "ssh_key_bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "hcloud_ssh_key" "ssh_keys" {
  name       = "ssh_key_bastion"
  public_key = tls_private_key.ssh_key_bastion.public_key_openssh

  lifecycle {
    create_before_destroy = true
  }
}

resource "local_sensitive_file" "private_key" {
  content  = tls_private_key.ssh_key_bastion.private_key_pem
  filename = "${var.local_files_path}/sshkey/private_key_bastion.pem"
}

resource "local_file" "public_key" {
  content  = tls_private_key.ssh_key_bastion.public_key_pem
  filename = "${var.local_files_path}/sshkey/public_key_bastion.pem"
}
