variable "name_prefix" {
  default     = "gh-pg-fs"
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

variable "application_name" {
  type        = string
  description = "The name of your application"
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment (dev, test, prod...)"
  default     = "dev"
}

variable "database_name" {
  type        = string
  description = "The PostgreSQL database name"
  default     = "db"
}

variable "administrator_login" {
  type        = string
  description = "The PostgreSQL administrator login"
  default     = "pgadmin"
}