# Hetzner Cloud API Token
variable "hcloud_token" {
  description = "The API token for Hetzner Cloud."
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.hcloud_token) > 0
    error_message = "Hetzner token cannot be empty."
  }
}

variable "image_name" {
  description = "The image name for the server (e.g., 'ubuntu-22.04')."
  type        = string

  validation {
    condition     = contains(["ubuntu-22.04"], var.image_name)
    error_message = "Unsupported image name. Supported images: ubuntu-22.04."
  }
}

variable "server_type" {
  description = "The type of server (e.g., 'cpx31')."
  type        = string
  default     = "cpx31"
}

variable "location" {
  description = "Location of the server (e.g., 'hel1')."
  type        = string
  default     = "hel1"
}
