variable "application_name" {
  type        = string
  description = "The name of your application"
  default     = "petclinic-ms-182746"
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
  default = "spring-petclinic-ms"
}

variable "database_name" {
  type        = string
  description = "The PostegreSQL database name"
  default     = "petclinic"
}

