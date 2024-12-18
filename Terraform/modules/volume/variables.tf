variable "volume_size" {
  description = "Volume size in GB for attached storage"
  type        = number
  default     = 50

  validation {
    condition     = var.volume_size >= 10
    error_message = "Volume size must be at least 10GBs"
  }
}

variable "shard_count" {
  description = "The total number of shards (servers) to be created"
  type        = number
  default     = 3

  validation {
    condition     = var.shard_count >= 1
    error_message = "Shard count must be at least 1."
  }
}
