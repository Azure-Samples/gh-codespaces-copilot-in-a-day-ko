variable "application_name" {
  type        = string
  description = "The name of your application"
  default     = "gh-ms-20469-db"
}

variable "environment" {
  type        = string
  description = "The environment (dev, test, prod...)"
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure region where all resources in this example should be created"
  default     = "eastus"
}

variable "dns_prefix" {
  type    = string
  default = "spring-gh-ms"
}

variable "database_name" {
  type        = string
  description = "The PostegreSQL database name"
  default     = "ghmstest"
}

