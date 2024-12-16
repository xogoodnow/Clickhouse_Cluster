variable "local_files_path" {
  description = "Path to store locally generated files (e.g., keys, certificates)."
  type        = string

  validation {
    condition     = fileexists(var.local_files_path)
    error_message = "Local folder path does not exists."
  }
}
