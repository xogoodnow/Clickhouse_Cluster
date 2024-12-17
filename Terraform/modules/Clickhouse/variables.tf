variable "local_files_path" {
  description = "Path to store locally generated files (e.g., keys, certificates)."
  type        = string

  validation {
    condition     = provider::local::direxists(pathexpand(var.local_files_path))
    error_message = "Local folder path does not exists."
  }
}
