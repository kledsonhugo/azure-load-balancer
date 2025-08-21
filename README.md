# staticsite-lb-azure

## Usage

### Setting Admin Password

For security, the admin password for virtual machines should be stored securely. This configuration supports two methods:

#### Method 1: Azure Key Vault (Recommended)

The most secure approach is to store the admin password in an external Azure Key Vault:

1. **Create a Key Vault and store the password:**
   ```bash
   # Create Key Vault (if you don't have one)
   az keyvault create --name "your-keyvault-name" --resource-group "your-keyvault-rg" --location "eastus2"
   
   # Store the admin password as a secret
   az keyvault secret set --vault-name "your-keyvault-name" --name "vm-admin-password" --value "YourSecurePassword123!"
   ```

2. **Configure Terraform to use Key Vault:**
   ```bash
   cp terraform/azure/terraform.tfvars.example terraform/azure/terraform.tfvars
   # Edit terraform.tfvars and uncomment/set the Key Vault variables:
   # key_vault_name                = "your-keyvault-name"
   # key_vault_resource_group_name = "your-keyvault-rg"
   # key_vault_secret_name         = "vm-admin-password"
   ```

3. **Ensure proper permissions:**
   Make sure your Terraform execution identity has `Key Vault Secrets User` role on the Key Vault.

#### Method 2: Direct Variable (Development/Testing)

For development or testing purposes, you can provide the password directly:

1. **Using terraform.tfvars file:**
   ```bash
   cp terraform/azure/terraform.tfvars.example terraform/azure/terraform.tfvars
   # Edit terraform.tfvars and set: admin_password = "YourSecurePassword123!"
   ```

2. **Using environment variable:**
   ```bash
   export TF_VAR_admin_password="YourSecurePassword123!"
   ```

3. **Using command line:**
   ```bash
   terraform apply -var="admin_password=YourSecurePassword123!"
   ```

**Note:** The password must be at least 8 characters long. Either Key Vault configuration or direct password must be provided.

