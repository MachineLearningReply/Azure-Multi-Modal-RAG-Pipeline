#!/bin/bash
# migrate-state.sh
# Script to migrate existing Terraform state to remote backend

set -e

echo "🔄 Migrating Terraform state to remote backend..."

# Check if backend block is uncommented
if grep -q "backend \"azurerm\"" main.tf && ! grep -q "/\*" main.tf; then
    echo "✅ Backend block is already uncommented"
else
    echo "❌ Please uncomment the backend block in main.tf first"
    echo "Remove the /* and */ around the backend \"azurerm\" block"
    exit 1
fi

# Check if we have local state to migrate
if [ -f "terraform.tfstate" ]; then
    echo "📁 Found local state file - will migrate to remote backend"
    
    # Backup local state
    cp terraform.tfstate terraform.tfstate.backup.$(date +%Y%m%d_%H%M%S)
    echo "💾 Created backup of local state"
    
    # Initialize with backend (this will prompt for migration)
    echo "🚀 Initializing Terraform with remote backend..."
    terraform init
    
    echo "✅ State migration completed!"
    echo "🧹 You can now safely delete the local terraform.tfstate file"
    
else
    echo "ℹ️  No local state file found - initializing fresh with remote backend"
    terraform init
fi

echo ""
echo "🎉 Remote state setup complete!"
echo "Your team can now collaborate using the shared remote state."
echo ""
echo "Team setup instructions:"
echo "1. Clone the repository"
echo "2. Run: terraform init"
echo "3. Terraform will automatically use the remote state"