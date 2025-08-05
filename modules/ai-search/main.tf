# modules/ai-search/main.tf
# Azure AI Search module - Enhanced to match Bicep configuration

# Create Azure AI Search service
resource "azurerm_search_service" "main" {
  name                = var.search_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  # Security settings
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = var.local_authentication_enabled
  authentication_failure_mode   = var.authentication_failure_mode

  # Advanced configuration from Bicep
  hosting_mode     = var.hosting_mode
  # Below three field cannot be set when using a free sku
  partition_count  = var.partition_count
  replica_count    = var.replica_count
  semantic_search_sku = var.semantic_search

  # System-assigned managed identity (matching Bicep)
  # So that Search service can authenticate to other Azure services (Storage, Key Vault, etc.)
  # Gives you future flexibility!
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}