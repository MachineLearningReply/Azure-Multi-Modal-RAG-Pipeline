
# modules/storage/main.tf
# Storage module - reusable storage account creation

# Create a storage account
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

  # Security settings
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = var.shared_access_key_enabled
  public_network_access_enabled   = var.public_network_access_enabled

  # Blob properties
  blob_properties {
    versioning_enabled = var.versioning_enabled
    
    delete_retention_policy {
      days = var.blob_retention_days
    }
  }

  tags = var.tags
}

# Create storage containers
resource "azurerm_storage_container" "containers" {
  for_each = toset(var.container_names)
  
  name                  = each.value
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.container_access_type
}