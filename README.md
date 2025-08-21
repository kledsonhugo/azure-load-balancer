# staticsite-lb-azure

## Usage

### Setting Admin Password

For security, the admin password for virtual machines is not hardcoded. You need to provide it using one of these methods:

1. **Using terraform.tfvars file (recommended):**
   ```bash
   cp terraform/azure/terraform.tfvars.example terraform/azure/terraform.tfvars
   # Edit terraform.tfvars and set your admin_password
   ```

2. **Using environment variable:**
   ```bash
   export TF_VAR_admin_password="YourSecurePassword123!"
   ```

3. **Using command line:**
   ```bash
   terraform apply -var="admin_password=YourSecurePassword123!"
   ```

**Note:** The password must be at least 8 characters long.

