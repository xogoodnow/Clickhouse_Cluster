output "ssh_key_ids" {
  description = "List of ssh-key IDs created."
  value       = values(hcloud_ssh_key.ssh_keys).*.id
}
