# variables.tf (Root module)
# Variables for the main configuration

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "storage_container_names" {
  description = "List of storage container names to create"
  type        = list(string)
  default     = ["documents"]
}

variable "container_access_type" {
  description = "Access type for containers"
  type        = string
  default     = "private"
}

variable "shared_access_key_enabled" {
  description = "Enable shared access keys for storage account"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access for storage account"
  type        = bool
  default     = true
}

variable "blob_versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

variable "blob_retention_days" {
  description = "Number of days to retain deleted blobs"
  type        = number
  default     = 7
}

variable "search_service_name" {
  description = "Name of the Azure AI Search service"
  type        = string
}

variable "search_sku" {
  description = "Azure AI Search service SKU (matching Bicep default: standard)"
  type        = string
  default     = "basic"
  validation {
    condition = contains([
      "free", "basic", "standard", "standard2", "standard3",
      "storage_optimized_l1", "storage_optimized_l2"
    ], var.search_sku)
    error_message = "Invalid search SKU."
  }
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

variable "search_local_auth_enabled" {
  description = "Enable local authentication for search service"
  type        = bool
  default     = true
}

variable "search_auth_failure_mode" {
  description = "Authentication failure mode for search service"
  type        = string
  default     = "http401WithBearerChallenge"
}

# New variables to match Bicep configuration
variable "search_hosting_mode" {
  description = "Hosting mode for the search service (from Bicep)"
  type        = string
  default     = "default"
  
  validation {
    condition     = contains(["default", "highDensity"], var.search_hosting_mode)
    error_message = "Hosting mode must be either 'default' or 'highDensity'."
  }
}

variable "search_partition_count" {
  description = "Number of partitions for the search service (from Bicep)"
  type        = number
  default     = 1
}

variable "search_replica_count" {
  description = "Number of replicas for the search service (from Bicep)"
  type        = number
  default     = 1
}

variable "search_semantic_search" {
  description = "Semantic search configuration (from Bicep: semanticSearch = 'free')"
  type        = string
  default     = "free"
  
  validation {
    condition     = contains(["disabled", "free", "standard"], var.search_semantic_search)
    error_message = "Semantic search must be 'disabled', 'free', or 'standard'."
  }
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}