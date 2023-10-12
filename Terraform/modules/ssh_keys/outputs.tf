output "public_key" {
  value = tls_private_key.ssh_key.public_key_pem
  description = "The public key data in PEM format"
  sensitive = true
}


