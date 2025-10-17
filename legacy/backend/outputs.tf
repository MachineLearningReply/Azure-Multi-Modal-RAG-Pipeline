# backend/outputs.tf
# Outputs for the Terraform state backend

output "storage_account_name" {
  description = "Name of the storage account for Terraform state"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_account_key" {
  description = "Primary access key for the storage account"
  value       = azurerm_storage_account.tfstate.primary_access_key
  sensitive   = true
}

output "container_name" {
  description = "Name of the container for Terraform state"
  value       = azurerm_storage_container.tfstate.name
}

output "resource_group_name" {
  description = "Name of the resource group containing the state storage"
  value       = azurerm_resource_group.tfstate.name
}

output "backend_config" {
  description = "Backend configuration block for main Terraform configuration"
  value = {
    resource_group_name  = azurerm_resource_group.tfstate.name
    storage_account_name = azurerm_storage_account.tfstate.name
    container_name       = azurerm_storage_container.tfstate.name
    key                  = "terraform.tfstate"
  }
}