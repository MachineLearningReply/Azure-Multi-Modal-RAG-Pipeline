# modules/ai-search/variables.tf
# Input variables for AI Search module - Enhanced to match Bicep configuration

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
  description = "Azure Search service SKU (passed from root)"
  type        = string
}

variable "hosting_mode" {
  description = "Hosting mode for the search service (passed from root)"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Enable public network access (Bicep: publicNetworkAccess)"
  type        = bool
  default     = true
}

variable "partition_count" {
  description = "Number of partitions for the search service (passed from root)"
  type        = number
}

variable "replica_count" {
  description = "Number of replicas for the search service (passed from root)"
  type        = number
}

variable "semantic_search" {
  description = "Semantic search configuration (passed from root)"
  type        = string
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