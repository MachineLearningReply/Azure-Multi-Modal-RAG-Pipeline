#!/bin/bash
# setup-remote-state.sh
# Bootstrap script to set up Azure remote state backend

set -e

echo "🚀 Setting up Terraform remote state backend..."

# Step 1: Create the backend infrastructure
echo "📦 Creating backend storage infrastructure..."
cd backend
terraform init
terraform plan
terraform apply -auto-approve

# Step 2: Get the storage account name from outputs
STORAGE_ACCOUNT_NAME=$(terraform output -raw storage_account_name)
echo "✅ Storage account created: $STORAGE_ACCOUNT_NAME"

# Step 3: Update main.tf with the actual storage account name
echo "🔧 Updating main.tf with backend configuration..."
cd ..
sed -i.bak "s/mlopstfstateXXXX/$STORAGE_ACCOUNT_NAME/g" main.tf

echo "✅ Backend configuration updated in main.tf"
echo ""
echo "🎯 Next steps:"
echo "1. Uncomment the backend block in main.tf"
echo "2. Run: terraform init"
echo "3. When prompted, type 'yes' to migrate existing state to remote backend"
echo ""
echo "Backend details:"
echo "  Resource Group: mlops-tfstate-rg"
echo "  Storage Account: $STORAGE_ACCOUNT_NAME"
echo "  Container: tfstate"