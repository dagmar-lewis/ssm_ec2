# Access a Private Ec2 Instance with AWS SSM

This project sets up an AWS environment with a VPC, a private subnet, and an EC2 instance. The EC2 instance is configured to be managed by AWS Systems Manager (SSM).

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- AWS Account with credentials configured for Terraform

## Usage

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd ssm_ec2
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Review the plan:**
   ```bash
   terraform plan
   ```

4. **Apply the configuration:**
   ```bash
   terraform apply
   ```

## CI/CD

This project uses GitHub Actions for CI/CD. The workflows are defined in the `.github/workflows` directory.

- `build_image.yml`: Builds a container image.
- `redeploy.yml`: Redeploys the application.
- `terraform_apply.yml`: Applies the Terraform configuration.
- `terraform_destroy.yml`: Destroys the Terraform-managed infrastructure.
- `terraform_plan.yml`: Creates a Terraform plan.

## Terraform Modules

The Terraform configuration is divided into the following files:

- `compute.tf`: Defines the EC2 instance.
- `iam.tf`: Defines the IAM roles and policies for the EC2 instance.
- `networking.tf`: Defines the VPC, subnet, security groups, and VPC endpoints.
- `provider.tf`: Configures the AWS provider.
- `variables.tf`: Defines the variables used in the Terraform configuration.
