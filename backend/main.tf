# backend/main.tf
# This configuration sets up the Azure Storage Account for Terraform remote state

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "azurerm" {
  features {}
}

# Generate a random suffix for globally unique storage account name
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# Resource group for Terraform state
resource "azurerm_resource_group" "tfstate" {
  name     = var.tfstate_resource_group_name
  location = var.location

  tags = {
    Environment = "infrastructure"
    Purpose     = "terraform-state"
    Project     = "MLOps-CoP"
  }
}

# Storage account for Terraform state
resource "azurerm_storage_account" "tfstate" {
  name                     = "${var.tfstate_storage_account_prefix}${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security settings
  public_network_access_enabled   = true
  shared_access_key_enabled       = true
  allow_nested_items_to_be_public = false

  # Enable versioning for state file protection
  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
  }

  tags = {
    Environment = "infrastructure"
    Purpose     = "terraform-state"
    Project     = "MLOps-CoP"
  }
}

# Container for Terraform state files
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# Get current client configuration
data "azurerm_client_config" "current" {}