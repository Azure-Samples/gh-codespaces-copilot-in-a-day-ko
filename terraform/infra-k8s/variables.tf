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

variable "acr_id" {
  type        = string
  description = "value of the Azure Container Registry resource id"
}

variable "dns_prefix" {
  type        = string
  description = "value of the DNS prefix specified when creating the managed cluster"
}