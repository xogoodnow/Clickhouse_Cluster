variable "local_files_path" {
  description = "Path to store local files generated"
  type        = string

  validation {
    condition     = length(var.local_files_path) > 0
    error_message = "Local file path cannot be empty"
  }
}
