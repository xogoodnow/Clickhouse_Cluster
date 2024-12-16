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

variable "shard_count" {
  description = "The total number of shards (servers) to be created"
  type        = number
  default     = 3

  validation {
    condition     = var.shard_count >= 3
    error_message = "Shard count must be at least 3."
  }
}

variable "ssh_key_master" {
  description = "Master SSH public key file path to be attached to all servers. Leave empty for no master SSH key."
  type        = string
}

variable "local_files_path" {
  description = "Path to store locally generated files (e.g., keys, certificates)."
  type        = string

  validation {
    condition     = fileexists(var.local_files_path)
    error_message = "Local folder path does not exists."
  }
}

variable "ansible_path" {
  description = "Path to the Ansible folder containing playbooks and configurations."
  type        = string

  validation {
    condition     = fileexists(var.ansible_path)
    error_message = "Ansible folder path does not exists."
  }
}
