# Azure-Multi-Modal-RAG-Pipeline

This project deploys Azure infrastructure for a multi-modal RAG (Retrieval-Augmented Generation) pipeline using Terraform. It provisions Azure Storage and AI Search services optimized for handling multimodal data.

## Prerequisites

- Terraform >= 1.0 (`brew install hashicorp/tap/terraform`)
- Azure CLI (`brew install azure-cli`)
- Azure subscription with appropriate permissions

## Authentication

Authenticate with Azure CLI:
```bash
az login
```

## Quick Start

### 1. Configure variables

Copy and customize the terraform.tfvars file with your specific values:
- `resource_group_name`: Your resource group name
- `storage_account_name`: Globally unique storage account name
- `search_service_name`: Your AI Search service name
- Update other variables as needed

### 2. Deploy infrastructure

```bash
# Initialize Terraform (run this first time or when adding new modules)
terraform init

# Check the current state 
terraform show 

# Preview the planned changes
terraform plan

# Apply the configuration
terraform apply

# Destroy all resources
terraform destroy

# Destroy a specific resource (e.g., search module)
terraform destroy -target=module.search
```

## Configuration Options

### Storage Configuration
- `storage_account_tier`: Standard or Premium (default: Standard)
- `storage_replication_type`: LRS, GRS, RAGRS, etc. (default: LRS)
- `storage_container_names`: List of containers to create (default: ["documents"])

### AI Search Configuration  
- `search_sku`: free, basic, standard, etc. (default: basic)
- `search_hosting_mode`: default or highDensity (default: default)
- `search_semantic_search`: disabled, free, or standard (default: free)

Note: Some features like partition_count and replica_count cannot be set with the free SKU.

## Commands

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply changes
terraform apply

# Destroy resources
terraform destroy

# Show current state
terraform show

# List resources
terraform state list
```

## Module Structure

- `modules/storage/`: Azure Storage Account and containers
- `modules/ai-search/`: Azure AI Search service
- `backend/`: Terraform state management resources

## Troubleshooting

1. **Storage account name conflicts**: Storage account names must be globally unique. Update the `storage_account_name` variable.

2. **SKU limitations**: Free AI Search SKU has limitations on partition_count, replica_count, and semantic_search features.