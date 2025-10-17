# modules/ai-search/outputs.tf
# Output values matching the Bicep template

output "id" {
  description = "The ID of the Azure AI Search service (matches Bicep output)"
  value       = azurerm_search_service.main.id
}

output "endpoint" {
  description = "The endpoint URL of the Azure AI Search service (matches Bicep output)"
  value       = "https://${azurerm_search_service.main.name}.search.windows.net/"
}

output "name" {
  description = "The name of the Azure AI Search service (matches Bicep output)"
  value       = azurerm_search_service.main.name
}

output "principal_id" {
  description = "The Principal ID of the system-assigned managed identity (matches Bicep output)"
  value       = azurerm_search_service.main.identity[0].principal_id
}

# Additional useful outputs for integration
output "query_keys" {
  description = "The query keys for the search service"
  value       = azurerm_search_service.main.query_keys
  sensitive   = true
}

output "primary_key" {
  description = "The primary admin key for the search service"
  value       = azurerm_search_service.main.primary_key
  sensitive   = true
}