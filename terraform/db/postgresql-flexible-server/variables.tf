variable "name_prefix" {
  default     = "postgresqlfs"
  description = "Prefix of the resource name."
}

variable "location" {
  default     = ""
  description = "Location of the resource."
}

variable "resource_group" {
  type        = string
  description = "The resource group"
  default     = ""
}