variable "agent_count" {
  default = 3
}

variable "resource_group" {
  type        = string
  description = "The resource group"
}

variable "application_name" {
  type        = string
  description = "The name of your application"
}

variable "environment" {
  type        = string
  description = "The environment (dev, test, prod...)"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "The Azure region where all resources in this example should be created"
}

variable "acr_id" {
  type        = string
  description = "value of the Azure Container Registry resource id"
}

variable "dns_prefix" {
  type        = string
  description = "value of the DNS prefix specified when creating the managed cluster"
}

variable "rbac" {
  description = "role based access control settings"
  type = object({
    enabled        = bool
    ad_integration = bool
  })
  default = {
    enabled        = true
    ad_integration = false
  }

  validation {
    condition = (
      (var.rbac.enabled && var.rbac.ad_integration) ||
      (var.rbac.enabled && var.rbac.ad_integration == false) ||
      (var.rbac.enabled == false && var.rbac.ad_integration == false)
    )
    error_message = "Role based access control must be enabled to use Active Directory integration."
  }
}