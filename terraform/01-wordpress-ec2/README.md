# 01 - WordPress on EC2 with Terraform



<img width="1359" height="731" alt="wordpress-terraform" src="https://github.com/user-attachments/assets/7b73a3a8-0b32-4b42-a865-7fdbc1ca68af" />
<img width="1353" height="720" alt="wordpress-80" src="https://github.com/user-attachments/assets/05102b9c-df15-4c01-801e-e9205fc460b4" />

## What I Built

A full WordPress stack on AWS provisioned entirely with Terraform.
No manual clicking in the AWS Console — everything is code.

The setup includes:
- EC2 instance running Amazon Linux 2023
- Apache, PHP, MariaDB, and WordPress installed automatically via user data
- Security group allowing HTTP (80) and SSH (22)
- Public IP output so you can open WordPress directly in the browser

## Architecture

```
Browser → Internet → EC2 Public IP (port 80)
                         └── Apache
                         └── PHP
                         └── WordPress
                         └── MariaDB (local)
```

## File Structure

```
01-wordpress-ec2/
├── providers.tf     # Terraform and AWS provider configuration
├── variables.tf     # All input variables (region, AMI, instance type)
├── sg.tf            # Security group (firewall rules)
├── ec2.tf           # EC2 instance resource
├── outputs.tf       # Prints public IP, URL, SSH command after apply
└── user-data.sh     # Bootstrap script that installs WordPress on boot
```

## How to Deploy

```bash
terraform init
terraform plan
terraform apply
```

Wait 3-5 minutes after apply for the user data script to finish.
Then open the URL from the output in your browser.

## How to Destroy

```bash
terraform destroy
```

## What I Learned

- How Terraform provisions real AWS infrastructure end to end
- The difference between `required_providers` and `provider` blocks
- How EC2 user data works — script runs automatically on first boot
- How security groups work in AWS — allow only, no deny rules
- How Terraform tracks infrastructure via `terraform.tfstate`
- Why state files should never be committed to Git
- Remote state best practice: S3 + DynamoDB for team environments

## Issues I Hit

**terraform init ran in empty directory**
- Cause: ran init before creating any .tf files
- Fix: created providers.tf first, then ran init again

**Provider block inside terraform block**
- Cause: misplaced closing brace
- Fix: provider block must be top level, not nested inside terraform block

**Missing required provider error**
- Cause: added provider block after the first terraform init
- Fix: ran terraform init again to download the new provider

## Notes

- AMI ID `ami-0c4596ce1e7ae3a60` is Amazon Linux 2023 in ca-central-1 only
- For production: restrict SSH to your IP instead of 0.0.0.0/0
- For production: use S3 + DynamoDB backend for remote state
