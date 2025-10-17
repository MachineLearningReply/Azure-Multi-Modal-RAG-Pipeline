# backend/variables.tf
# Variables for the Terraform state backend infrastructure

variable "tfstate_resource_group_name" {
  description = "Name of the resource group for Terraform state storage"
  type        = string
  default     = "mlops-tfstate-rg"
}

variable "tfstate_storage_account_prefix" {
  description = "Prefix for the storage account name (will be suffixed with random number)"
  type        = string
  default     = "mlopstfstate"
  
  validation {
    condition     = length(var.tfstate_storage_account_prefix) <= 20
    error_message = "Storage account prefix must be 20 characters or less to allow for random suffix."
  }
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "West Europe"
}