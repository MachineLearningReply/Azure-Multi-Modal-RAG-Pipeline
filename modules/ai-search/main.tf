# modules/search/main.tf
# Azure AI Search module

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

  tags = var.tags
}