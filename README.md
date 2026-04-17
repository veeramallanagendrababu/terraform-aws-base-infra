
TERRAFORM COMMANDS
------------------------------------
terraform init
naga@Nag:~/Terraform/terraform-aws-infra-1/environment/mgmt$ terraform init

terraform validate
naga@Nag:~/Terraform/terraform-aws-infra-1/environment/mgmt$ terraform validate

terraform plan -var-file="mgmt.tfvars"                                 <-- preview plan
naga@Nag:~/Terraform/terraform-aws-infra-1/environment/mgmt$ terraform plan -var-file="mgmt.tfvars"

terraform apply -var-file="mgmt.tfvars"                                 <-- execute plan
naga@Nag:~/Terraform/terraform-aws-infra-1/environment/mgmt$ terraform apply -var-file="mgmt.tfvars"

terraform destroy -var-file="mgmt.tfvars"                               <--- destory execueted plan
naga@Nag:~/Terraform/terraform-aws-infra-1/environment/mgmt$ terraform destroy -var-file="mgmt.tfvars"






Terraform AWS Architecture (Visual Diagram):
-------------------------------------------
                        ┌──────────────────────────┐
                        │        Internet          │
                        └──────────┬───────────────┘
                                   │
                                   │ HTTP (80)
                                   │ SSH (22)
                                   ▼
                    ┌──────────────────────────────┐
                    │   Internet Gateway (IGW)     │
                    └──────────┬───────────────────┘
                               │
                               ▼
        ┌──────────────────────────────────────────────┐
        │                VPC (10.0.0.0/16)             │
        │                                              │
        │   ┌──────────────────────────────────────┐   │
        │   │         Public Subnet (10.0.1.0/24)  │   │
        │   │                                      │   │
        │   │   ┌──────────────────────────────┐   │   │
        │   │   │   EC2 Instance (t2.micro)    │   │   │
        │   │   │                              │   │   │
        │   │   │  Apache HTTP Server (80)     │   │   │
        │   │   │  SSH Access (22)             │   │   │
        │   │   └──────────────┬───────────────┘   │   │
        │   │                  │                   │   │
        │   │   Security Group │ (Firewall Rules)  │   │
        │   │   - Allow SSH     │                  │   │
        │   │   - Allow HTTP    │                  │   │
        │   └──────────────────────────────────────┘   │
        │                                              │
        │   Route Table: 0.0.0.0/0 → IGW               │
        └──────────────────────────────────────────────┘


Terraform Module Mapping (How your code builds this):
----------------------------------------------------
environment/mgmt
        │
        ├── networking module
        │       ├── VPC
        │       ├── Subnet
        │       ├── IGW
        │       └── Route Table
        │
        ├── security module
        │       └── Security Group (SG)
        │
        └── compute module
                └── EC2 Instance

Flow of creation:
------------------
Terraform Apply
      │
      ▼
1. Create VPC
      │
      ▼
2. Create Subnet
      │
      ▼
3. Attach Internet Gateway
      │
      ▼
4. Create Route Table (0.0.0.0/0 → IGW)
      │
      ▼
5. Create Security Group (SSH + HTTP rules)
      │
      ▼
6. Launch EC2 in Subnet
      │
      ▼
7. Attach Security Group to EC2
      │
      ▼
8. Install Apache using user_data

git commands:
--------------------
  # rm -rf .git
 # git init
 # vi .gitignore
 # git add .
 # git commit -m "Clean Terraform infrastructure without secrets"
 # git status
 #  git remote add origin https://github.com/veeramallanagendrababu/terraform-aws-base-infra.git
 # git branch -M main
 #  git push -u origin main
