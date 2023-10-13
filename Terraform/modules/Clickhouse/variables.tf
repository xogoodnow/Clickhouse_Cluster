variable "hcloud_token" {
  description = "The api key for hetzner"
  sensitive = true # Requires terraform >= 0.14
  type = string
}
