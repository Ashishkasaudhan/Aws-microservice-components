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
| [aws_cloudwatch_log_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_elasticache_cluster.onehub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.elastic_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | The whitelisted CIDRs which to allow `ingress` traffic to LB | `any` | n/a | yes |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | n/a | `any` | n/a | yes |
| <a name="input_aws_cloudwatch_log_group_name"></a> [aws\_cloudwatch\_log\_group\_name](#input\_aws\_cloudwatch\_log\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `any` | n/a | yes |
| <a name="input_elastic_cache_security_group_name"></a> [elastic\_cache\_security\_group\_name](#input\_elastic\_cache\_security\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | n/a | `any` | n/a | yes |
| <a name="input_num_cache_nodes"></a> [num\_cache\_nodes](#input\_num\_cache\_nodes) | n/a | `any` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | n/a | `any` | n/a | yes |
| <a name="input_subnet1"></a> [subnet1](#input\_subnet1) | n/a | `any` | n/a | yes |
| <a name="input_subnet2"></a> [subnet2](#input\_subnet2) | n/a | `any` | n/a | yes |
| <a name="input_subnet3"></a> [subnet3](#input\_subnet3) | n/a | `any` | n/a | yes |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_address"></a> [cluster\_address](#output\_cluster\_address) | address of elastic cache cluster with arn |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | name of elastic cache cluster with arn |
<!-- END_TF_DOCS -->