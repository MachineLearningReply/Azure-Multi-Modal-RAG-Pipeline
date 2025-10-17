
# modules/storage/variables.tf
# Input variables for storage module

variable "storage_account_name" {
  description = "Name of the storage account"
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

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Storage replication type"
  type        = string
  default     = "LRS"
}

variable "container_names" {
  description = "List of container names to create"
  type        = list(string)
  default     = []
}

variable "container_access_type" {
  description = "Access type for containers"
  type        = string
  default     = "private"
}

variable "shared_access_key_enabled" {
  description = "Enable shared access keys"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

variable "blob_retention_days" {
  description = "Number of days to retain deleted blobs"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags to apply to storage resources"
  type        = map(string)
  default     = {}
}
