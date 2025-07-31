# main.tf (Root module)
# This file orchestrates all the modules

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Remote state backend configuration
  # Run the backend setup first: cd backend && terraform apply
  # Then uncomment this block and migrate state: terraform init
  /*
  backend "azurerm" {
    resource_group_name  = "mlops-tfstate-rg"
    storage_account_name = "mlopstfstateXXXX"  # Replace XXXX with actual suffix from backend output
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  */
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = var.common_tags
}

# Call the storage module
module "storage" {
  source = "./modules/storage"

  # Required parameters
  storage_account_name = var.storage_account_name
  resource_group_name  = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  # Optional parameters
  account_tier                    = var.storage_account_tier
  replication_type               = var.storage_replication_type
  container_names                = var.storage_container_names
  container_access_type          = var.container_access_type
  shared_access_key_enabled      = var.shared_access_key_enabled
  public_network_access_enabled  = var.public_network_access_enabled
  versioning_enabled             = var.blob_versioning_enabled
  blob_retention_days            = var.blob_retention_days

  tags = var.common_tags
}

# Call the search module
module "search" {
  source = "./modules/ai-search"

  # Required parameters
  search_service_name = var.search_service_name
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location

  # Optional parameters
  sku                            = var.search_sku
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = var.search_local_auth_enabled
  authentication_failure_mode   = var.search_auth_failure_mode

  tags = var.common_tags

  # Ensure search is created after storage
  depends_on = [module.storage]
}
