# sample-app

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.42.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sample_app_sa_role"></a> [sample\_app\_sa\_role](#module\_sample\_app\_sa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.eks](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | aws profile | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | application environment | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | k8s namespace | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | project name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | k8s deployment name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | default tag for all AWS resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_serviceaccount_name"></a> [serviceaccount\_name](#output\_serviceaccount\_name) | K8s serviceaccount name |
| <a name="output_serviceaccount_namespace"></a> [serviceaccount\_namespace](#output\_serviceaccount\_namespace) | K8s serviceaccount namespace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
