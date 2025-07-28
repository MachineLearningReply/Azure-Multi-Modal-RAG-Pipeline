# modules/search/variables.tf
# Input variables for search module

variable "search_service_name" {
  description = "Name of the Azure AI Search service"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "Azure Search service SKU"
  type        = string
  default     = "free"
  validation {
    condition = contains([
      "free", "basic", "standard", "standard2", "standard3",
      "storage_optimized_l1", "storage_optimized_l2"
    ], var.sku)
    error_message = "SKU must be one of: free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2."
  }
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "local_authentication_enabled" {
  description = "Enable local authentication (API keys)"
  type        = bool
  default     = true
}

variable "authentication_failure_mode" {
  description = "Authentication failure mode"
  type        = string
  default     = "http401WithBearerChallenge"
}

variable "storage_account_id" {
  description = "ID of the storage account to connect to (optional)"
  type        = string
  default     = null
}

variable "create_storage_connection" {
  description = "Create a private link connection to storage account"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to search resources"
  type        = map(string)
  default     = {}
}