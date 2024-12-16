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

variable "environment" {
  description = "Deployment environment (e.g., 'prod', 'stage', 'beta', 'lab')."
  type        = string
  default     = "prod"

  validation {
    condition     = contains(["prod", "stage", "beta", "lab"], var.environment)
    error_message = "Invalid environment. Valid options: prod, stage, beta, lab."
  }
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

variable "ansible_path" {
  description = "Path to the Ansible folder containing playbooks and configurations."
  type        = string

  validation {
    condition     = fileexists(var.ansible_path)
    error_message = "Ansible folder path does not exists."
  }
}


variable "ssh_key_ids" {
  description = "List of ssh public keys which should be injected into the server at creation"
  nullable    = false
  type        = list(string)

  validation {
    condition     = length(var.ssh_key_ids) > 0
    error_message = "At least 1 ssh-key is needed"
  }
}
