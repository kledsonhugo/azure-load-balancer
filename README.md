# staticsite-lb-azure

Azure Load Balancer infrastructure with virtual machines.

## Usage

1. Copy the example variables file:
```bash
cp terraform/azure/terraform.tfvars.example terraform/azure/terraform.tfvars
```

2. Set your secure admin password in `terraform/azure/terraform.tfvars`:
```
admin_password = "YourSecurePassword123!"
```

3. Deploy the infrastructure:
```bash
cd terraform/azure
terraform init
terraform plan
terraform apply
```

## Security Notes

- The admin_password variable is marked as sensitive and will not be displayed in logs
- Password must be at least 8 characters and contain uppercase, lowercase, number, and special character
- The terraform.tfvars file is ignored by git to prevent accidental commits of sensitive data
