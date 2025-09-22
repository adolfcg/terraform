# Terraform Project - AI Coding Instructions

## Project Overview
This is a simple Terraform project for learning and testing AWS infrastructure provisioning. The project currently contains basic EC2 instance definitions.

## Architecture & Patterns

### Resource Structure
- **Single-file setup**: All Terraform resources are currently defined in `test.tf`
- **AWS Provider**: Project uses AWS as the primary cloud provider
- **Resource naming**: Uses descriptive resource names (e.g., `aws_instance.myec2`)

### Current Resources
- `aws_instance.myec2`: Basic EC2 instance with hardcoded AMI (`ami-00c39f71452c08778`) and `t2.micro` instance type

## Development Guidelines

### Terraform Best Practices for This Project
- When adding new resources, consider whether they belong in `test.tf` or should be organized into separate files
- AMI IDs should be parameterized using variables rather than hardcoded for better reusability
- Use consistent resource naming patterns: `<service>_<resource_type>.<descriptive_name>`

### Suggested Improvements
When expanding this project, consider:
1. **Variables**: Create `variables.tf` to parameterize AMI IDs, instance types, and regions
2. **Outputs**: Add `outputs.tf` to expose important resource attributes (instance IDs, public IPs)
3. **Provider configuration**: Add explicit provider blocks with version constraints
4. **State management**: Consider remote state storage for collaborative development

### Common Commands
- `terraform init`: Initialize the Terraform configuration
- `terraform plan`: Preview infrastructure changes
- `terraform apply`: Apply the configuration to create/update resources
- `terraform destroy`: Clean up all created resources

## Key Files
- `test.tf`: Main Terraform configuration file containing all current resources

## Notes for AI Agents
- This appears to be a learning/testing environment - prioritize educational clarity over production complexity
- When suggesting changes, explain the reasoning behind Terraform best practices
- Always recommend `terraform plan` before `terraform apply` for safety
- Be mindful of AWS costs when suggesting new resources