variable "hcloud_token" {
  description = "The api key for hetzner"
  sensitive = true # Requires terraform >= 0.14
  type = string
}

variable "image_name" {
  description = "The image name for the server"
  type = string
  validation {
    condition = contains(["ubuntu-22.04"], var.image_name )
    error_message = "The image name is not supported"

  }
}

variable "server_type" {
  description = "The type of server"
  type = string
  default = "cpx31"
  validation {
    condition = contains(["cpx31", "cpx11", "cx21"], var.server_type)
    #Additional servertypes will be added
    error_message = "Lower than cpx31 would not be sufficient for the cluster"

  }
}


variable "location" {
  description = "Location of the server"
  type = string
  default = "hel1"
  validation {
    condition = contains(["hel1"], var.location)
    error_message = "No other locations are supported"
    #Other location will be added

  }

}