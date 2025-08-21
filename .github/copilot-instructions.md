# Azure Load Balancer Infrastructure

Azure Load Balancer is a Terraform-based Infrastructure as Code (IaC) project that deploys an Azure load balancer with two Ubuntu VMs serving a PHP info application. The infrastructure includes networking, security groups, virtual machines, and load balancing components for demonstrating Azure load balancing capabilities.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Prerequisites and Environment Setup
- Install Terraform 1.11.4 (exact version required by CI/CD):
  ```bash
  cd /tmp
  wget https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_amd64.zip
  unzip terraform_1.11.4_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  terraform version
  ```

### Build and Validation Commands
All Terraform commands must be run from the repository root using the `-chdir` option, matching the CI/CD pipeline:

#### Basic Validation (No Azure Credentials Required)
- Initialize Terraform without backend: `terraform -chdir=./terraform/azure init -backend=false` -- takes 30-60 seconds. NEVER CANCEL. Set timeout to 90+ seconds.
- Validate configuration: `terraform -chdir=./terraform/azure validate` -- takes 5 seconds
- Check formatting: `terraform -chdir=./terraform/azure fmt -check` -- takes 2 seconds
- Format code: `terraform -chdir=./terraform/azure fmt` -- takes 2 seconds

#### Full Infrastructure Operations (Requires Azure Credentials)
- Initialize with backend: `terraform -chdir=./terraform/azure init` -- takes 30-60 seconds. NEVER CANCEL. Set timeout to 90+ seconds.
- Plan infrastructure changes: `terraform -chdir=./terraform/azure plan -out tfplan` -- takes 30-60 seconds. NEVER CANCEL. Set timeout to 120+ seconds.
- Apply infrastructure: `terraform -chdir=./terraform/azure apply tfplan` -- takes 10-20 minutes. NEVER CANCEL. Set timeout to 30+ minutes.
- Show current state: `terraform -chdir=./terraform/azure show` -- takes 10-30 seconds
- Destroy infrastructure: `terraform -chdir=./terraform/azure destroy` -- takes 10-15 minutes. NEVER CANCEL. Set timeout to 25+ minutes.

#### Required Azure Environment Variables
For deployment operations, these environment variables must be set:
```bash
export ARM_CLIENT_ID="<service-principal-client-id>"
export ARM_CLIENT_SECRET="<service-principal-client-secret>"
export ARM_SUBSCRIPTION_ID="<azure-subscription-id>"
export ARM_TENANT_ID="<azure-tenant-id>"
```

## Validation and Testing

### Infrastructure Validation Scenarios
After deploying infrastructure, always validate these components:

1. **Load Balancer Accessibility**: 
   - Get load balancer URL: `terraform -chdir=./terraform/azure output lb_url`
   - Access the URL to see PHP info page served by one of the backend VMs
   - Refresh multiple times to verify load balancing between VMs

2. **Individual VM Accessibility**:
   - Get VM01 IP: `terraform -chdir=./terraform/azure output vm01_public_ip` 
   - Get VM02 IP: `terraform -chdir=./terraform/azure output vm02_public_ip`
   - Access both IPs on port 80 - both should serve the same PHP info page

3. **Network Connectivity**:
   - SSH access to VMs using credentials: username `vmuser`, password `Password1234!`
   - Verify Apache service: `sudo systemctl status apache2`
   - Verify PHP installation: `php --version`
   - Check deployed application: `ls -la /var/www/html/`

4. **Infrastructure State Verification**:
   - List all resources: `terraform -chdir=./terraform/azure state list`
   - Show resource details: `terraform -chdir=./terraform/azure show`
   - Verify resource counts match expected infrastructure

### Code Quality Checks
Always run these before committing changes:
- `terraform -chdir=./terraform/azure fmt -check` -- ensure proper formatting
- `terraform -chdir=./terraform/azure validate` -- verify configuration syntax
- `terraform -chdir=./terraform/azure plan` -- review planned changes (requires Azure credentials)

## Common Tasks

### Repository Structure
```
├── README.md                          # Basic project description
├── terraform/
│   └── azure/
│       ├── main.tf                    # Main infrastructure definitions
│       ├── provider.tf                # Azure provider and backend config
│       ├── output.tf                  # Output values (IPs, URLs)
│       └── scripts/
│           └── cloud_init.sh          # VM initialization script
├── .github/
│   └── workflows/
│       └── workflow.yaml              # CI/CD pipeline
└── .gitignore                         # Terraform-specific ignores
```

### Key Infrastructure Components (main.tf)
- **Virtual Network**: Single VNet with two subnets (VMs and App Gateway)
- **Virtual Machines**: Two Ubuntu 24.04 VMs (Standard_D2s_v3) with Apache/PHP
- **Load Balancer**: Azure Standard SKU load balancer with health probes
- **Network Security**: NSG allowing HTTP (80) and SSH (22) traffic
- **Public IPs**: Separate public IPs for load balancer and each VM

### Backend Configuration (provider.tf)
- Uses Azure backend for state storage in `azureloadbalancertf` storage account
- Requires Azure Resource Manager provider >= 4.28.0
- Resource group prevention for easy cleanup during development

### VM Initialization (scripts/cloud_init.sh)
- Installs Apache2, PHP, and required packages
- Clones external PHP info application from `kledsonhugo/app-dynamicsite`
- Configures web server to serve PHP info page

### CI/CD Pipeline (.github/workflows/workflow.yaml)
- **CI Job**: Tests configuration with `terraform init` and `terraform validate`
- **CD Job**: Deploys to Azure on main branch pushes using `terraform plan` and `terraform apply`
- Requires Azure service principal credentials as GitHub secrets
- Uses Terraform 1.11.4 consistently across environments

## Troubleshooting

### Common Issues
1. **Backend Initialization Errors**: Run `terraform init` first, ensure Azure credentials are set
2. **Provider Download Timeout**: Increase timeout, network issues may cause delays
3. **Azure Authentication Errors**: Verify all four ARM_* environment variables are set correctly
4. **State Lock Errors**: Check if another deployment is running, wait for completion
5. **Resource Conflicts**: Ensure resource group name is unique or doesn't exist

### Recovery Actions
- **Reset Terraform State**: `rm -rf .terraform .terraform.lock.hcl && terraform init`
- **Force Unlock State**: `terraform force-unlock <lock-id>` (use only when necessary)
- **Plan Verification**: Always run `terraform plan` before `terraform apply`

## Expected Output and Resource Inventory
After successful deployment:
- **Load Balancer URL**: `http://azureloadbalancer001.eastus2.cloudapp.azure.com`
- **Resource Count**: 20 total resources deployed
- **Key Resources Created**:
  - 1 Resource Group (`rg-appstaticsitelb`)
  - 1 Virtual Network with 2 subnets
  - 2 Ubuntu VMs (`vm01`, `vm02`) with public IPs
  - 1 Standard Load Balancer with backend pool
  - 1 Network Security Group with HTTP/SSH rules
  - 1 Availability Set for VM fault tolerance

### Resource Naming Convention
- Virtual Machines: `vm01`, `vm02`
- Network Interfaces: `vm01-nic`, `vm02-nic` 
- Public IPs: `vm01-ip`, `vm02-ip`, `lb`
- Storage Disks: `vm01-os-disk`, `vm02-os-disk`
- Load Balancer: `lb` with frontend configuration
- Domain Name: `azureloadbalancer001.eastus2.cloudapp.azure.com`

### PHP Application Validation
The deployed PHP info page should display:
- Server information including PHP version
- Apache configuration details
- System information (OS, hardware specs)
- Network configuration
- Different server names when accessing through load balancer (demonstrating load balancing)

## Development Workflow

### Making Infrastructure Changes
1. Always validate locally first: `terraform -chdir=./terraform/azure init -backend=false`
2. Check formatting: `terraform -chdir=./terraform/azure fmt -check`
3. Validate syntax: `terraform -chdir=./terraform/azure validate`
4. Review changes: `terraform -chdir=./terraform/azure plan` (requires Azure credentials)
5. Test deployment in development environment before main branch merge

### CI/CD Integration
- **Automatic Testing**: Every push triggers validation via GitHub Actions
- **Automatic Deployment**: Pushes to main branch trigger deployment to Azure
- **Required Secrets**: ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID
- **Pipeline Duration**: CI takes ~2-3 minutes, CD takes ~15-20 minutes total

### Best Practices
- Always test infrastructure changes in a separate subscription/resource group first
- Use `terraform plan` to review changes before applying
- Monitor deployment logs in GitHub Actions for any issues
- Keep `.terraform.lock.hcl` file committed to ensure consistent provider versions
- Use `terraform destroy` in development environments to save costs