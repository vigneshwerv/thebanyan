variable "hcloud_token" {
  type = string
}

variable "location" {
  type = string
  // Default location is Hillsboro, OR (us-west)
  default = "hil"
}
