# terraform.tfvars
# Your specific configuration values

# Basic configuration
resource_group_name   = "mlops-nlp-cop-rg"
location             = "West Europe"
storage_account_name = "multimodalragstore2025"  

# Storage configuration
storage_account_tier       = "Standard"
storage_replication_type   = "LRS"
storage_container_names    = ["documents", "preprocessed"]
container_access_type      = "private"

# Security Settings
shared_access_key_enabled        = true
public_network_access_enabled    = true
search_local_auth_enabled        = true
search_auth_failure_mode         = "http401WithBearerChallenge"
local_authentication_enabled     = true
blob_versioning_enabled          = false
blob_retention_days             = 7

# Search Configuration (enhanced to match Bicep)
search_service_name        = "mmrag-search-service"
search_sku                = "basic"
search_hosting_mode       = "default"
# Below three field cannot be set when using a free search_sku
search_partition_count    = 1
search_replica_count      = 1
search_semantic_search    = "free"  # Matches Bicep semanticSearch: 'free'

# Tags
common_tags = {
  Project     = "MLOps-CoP"
  Owner       = "j.padhye@reply.de"
}