include {
  path = find_in_parent_folders()
}


locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment      = local.environment_vars.locals.environment

}


terraform {
  source = "../../../../../Terraform/modules/elastic_cache/"
}

dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  elastic_cache_security_group_name = "devopslogic-${local.environment}-elastic_cache-sg"
  aws_cloudwatch_log_group_name = "devopslogic-${local.environment}-cw-group"
  environment = local.environment
  application_name = "devopslogic-${local.environment}"
  subnet_group_name   = "devopslogic-${local.environment}-elastic-cache"
  subnet1               = dependency.vpc.outputs.private_subnets[0]
  subnet2               = dependency.vpc.outputs.private_subnets[1]
  subnet3               = dependency.vpc.outputs.private_subnets[2]
  cluster_id = "devopslogic-${local.environment}-ec-cluster"
  engine_type = "redis"
  node_type = "cache.t3.medium"
  num_cache_nodes = 1
  port  = 6379
  vpc_id                 = dependency.vpc.outputs.vpc_id
  allowed_cidr_blocks = dependency.vpc.outputs.vpc_cidr_block

}
