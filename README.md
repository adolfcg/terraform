# Terraform
## Prerequisites

The version we used for terraform and gcloud utilities used to deploy this solution is:

```
terraform --version
Terraform v1.7.3
on darwin_arm64

gcloud --version
Google Cloud SDK 463.0.0
alpha 2024.02.02
beta 2024.02.02
bq 2.0.101
core 2024.02.02
gsutil 5.27
```

## Authentication and Authorization

To authenticate users or applications in your Google Cloud project is required to create a service account. A service account is a special kind of account that is typically used by applications and virtual machines in your Google Cloud project to access APIs and services. Applications and users can authenticate as a service account using generated service account keys.

The downside to this approach is that it creates a security risk as soon as the key is generated and distributed. Any user with access to a service account key, whether authorized or not, will be able to authenticate as the service account and access all the resources for which the service account has permissions.  Fortunately, there’s another way to run Terraform code as a service that’s generally safer - service account impersonation.

To begin creating resources as a service account you’ll need two things. First, you’ll need a service account in your project that you’ll use to run the Terraform code.  This service account will need to have the permissions to create the resources referenced in your code. Second,  you’ll need to have the Service Account Token Creator IAM role granted to your own user account.  This role enables you to impersonate service accounts to access APIs and resources.  The IAM role can be granted on the project’s IAM policy, thereby giving you impersonation permissions on all service accounts in the project. However, if you’re adhering to the [principle of least privilege](https://www.youtube.com/watch?v=8GZ6516Kao4), the role should be granted to you on the service account’s IAM policy instead.

The service account used, and the roles required to deploy each services can be found in the AIM menu of GCP copnsole.

terraform@PROJECT

- AI Platform Admin
- Cloud Functions Admin
- Cloud Functions Developer
- Cloud Functions Invoker
- Dialogflow API Admin
- Discovery Engine Admin
- Document AI Administrator
- Document AI Editor
- Service Account Token Creator
- Service Account User
- Storage Admin
- Vertex AI administrator
- Vertex AI user

## Scripts execution

The /tf directory inside the Github repository contains all the scripts used to deploy the components required for this solution, main.tf is the starting execution point where all the modules are invoked. find in /modules directory all the components divided maintaining modularity as a good practice required. In order to execute the terraform files follow the instructions below:

`terraform init`

`terraform plan`

`terraform apply`

`Apply complete! Resources: 18 added, 0 changed, 0 destroyed.`

Once deployed, some considerations are important, the component `gcloud_ai_index_endpoints_deploy_index` cannot currently be deployed using a terraform verified module. There is currently an open issue on github's hashicorp to fix this problem [[link](https://github.com/hashicorp/terraform-provider-google/issues/12818)], so we are introducing a workaround using local-exec and gcloud directives in the `gcloud_ai_index_endpoints_deploy_index module`. Please note that this is only a workaround, and the module may produce unexpected results. Alternatively, the glcloud command can be run externally in local or as part an agent execution in a CICD system.

It is also important to note that the Agent Builder component creates a data store that is provisioned asynchronously in the background. Since this is a process running in the background, it is not possible to know when the deployment execution is finished, so if you tried to destroy the components immediately after they have been deployed, you will get an error saying that the deployment process is still running.
