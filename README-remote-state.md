# Terraform Remote State Setup

This project uses Azure Storage for remote state management to enable team collaboration and state backup.

## Quick Start

### Initial Setup (First Time Only)

1. **Set up the remote state backend:**
   ```bash
   ./scripts/setup-remote-state.sh
   ```

2. **Uncomment the backend block in `main.tf`:**
   Remove the `/*` and `*/` around the backend configuration.

3. **Migrate existing state:**
   ```bash
   ./scripts/migrate-state.sh
   ```

### Team Member Setup

New team members just need to:
```bash
git clone <repository>
cd Azure-Multi-Modal-RAG-Pipeline
az login
terraform init
```

Terraform will automatically use the remote state.

## Architecture

```
📁 Project Structure
├── backend/                 # Backend infrastructure
│   ├── main.tf             # Storage account for state
│   ├── variables.tf        # Backend variables
│   ├── outputs.tf          # Backend outputs
│   └── terraform.tfvars    # Backend config
├── scripts/
│   ├── setup-remote-state.sh   # Bootstrap script
│   └── migrate-state.sh        # Migration script
└── main.tf                 # Main config (with backend block)
```

## Resources Created

The backend setup creates:
- **Resource Group**: `mlops-tfstate-rg`
- **Storage Account**: `mlopstfstate{random}` 
- **Blob Container**: `tfstate`

## Features

- ✅ **State Locking**: Prevents concurrent modifications
- ✅ **Versioning**: 30-day retention for state file versions
- ✅ **Security**: Private container, encrypted storage
- ✅ **Collaboration**: Shared state across team members

## Manual Backend Configuration

If you prefer manual setup, add this to your `main.tf`:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "mlops-tfstate-rg"
    storage_account_name = "mlopstfstateXXXX"  # Get from backend output
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```

## Troubleshooting

### State Lock Issues
```bash
# Force unlock if needed (use carefully)
terraform force-unlock <lock-id>
```

### Backend Reconfiguration
```bash
# Reconfigure backend
terraform init -reconfigure
```

### Access Issues
Ensure you're authenticated to Azure:
```bash
az login
az account set --subscription <subscription-id>
```