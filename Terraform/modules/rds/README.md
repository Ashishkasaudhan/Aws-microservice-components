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
| [aws_db_instance.devops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.dbsubnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | The whitelisted CIDRs which to allow `ingress` traffic to LB | `list` | <pre>[<br>  "10.2.0.0/16"<br>]</pre> | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | n/a | `bool` | `false` | no |
| <a name="input_bastion_cidr_blocks"></a> [bastion\_cidr\_blocks](#input\_bastion\_cidr\_blocks) | n/a | `list` | <pre>[<br>  "10.2.0.0/16"<br>]</pre> | no |
| <a name="input_database_engine"></a> [database\_engine](#input\_database\_engine) | n/a | `string` | `"mysql"` | no |
| <a name="input_database_engine_version"></a> [database\_engine\_version](#input\_database\_engine\_version) | n/a | `string` | `"8.0"` | no |
| <a name="input_db_indentifier"></a> [db\_indentifier](#input\_db\_indentifier) | n/a | `string` | `""` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | n/a | `string` | `""` | no |
| <a name="input_db_security_group_name"></a> [db\_security\_group\_name](#input\_db\_security\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_db_security_group_name_desc"></a> [db\_security\_group\_name\_desc](#input\_db\_security\_group\_name\_desc) | n/a | `string` | `"security-group-for-RDS"` | no |
| <a name="input_db_subnet_grpup_name"></a> [db\_subnet\_grpup\_name](#input\_db\_subnet\_grpup\_name) | n/a | `string` | `"db_subnet_group"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | n/a | `string` | `"root"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | n/a | `bool` | `true` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_public_access"></a> [public\_access](#input\_public\_access) | n/a | `bool` | `false` | no |
| <a name="input_rds_instance_type"></a> [rds\_instance\_type](#input\_rds\_instance\_type) | n/a | `string` | `"value"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `true` | no |
| <a name="input_storage_in_db"></a> [storage\_in\_db](#input\_storage\_in\_db) | n/a | `number` | `50` | no |
| <a name="input_subnet1"></a> [subnet1](#input\_subnet1) | n/a | `any` | n/a | yes |
| <a name="input_subnet2"></a> [subnet2](#input\_subnet2) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->