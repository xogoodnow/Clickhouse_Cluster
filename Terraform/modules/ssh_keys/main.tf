

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "hcloud_ssh_key" "ssh_key" {
  name       = "ssh_key_bastion"
  public_key = tls_private_key.ssh_key.public_key_openssh



  lifecycle {
    create_before_destroy = true
  }
}


resource "local_sensitive_file" "private_key" {
  content = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/../../sshkey/private_key.pem"
}

resource "local_file" "public_key" {
  content = tls_private_key.ssh_key.public_key_pem
  filename = "${path.module}/../../sshkey/public_key.pem"
}




