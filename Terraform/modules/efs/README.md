<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.efs-mt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_security_group.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | The whitelisted CIDRs which to allow `ingress` traffic to LB | `any` | n/a | yes |
| <a name="input_efs_name"></a> [efs\_name](#input\_efs\_name) | n/a | `string` | `""` | no |
| <a name="input_efs_security_group_name"></a> [efs\_security\_group\_name](#input\_efs\_security\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_efs_security_group_name_desc"></a> [efs\_security\_group\_name\_desc](#input\_efs\_security\_group\_name\_desc) | n/a | `string` | `"security-group-for-EFS"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs"></a> [efs](#output\_efs) | name of efs cluster with arn |
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | address of efs id |
<!-- END_TF_DOCS -->