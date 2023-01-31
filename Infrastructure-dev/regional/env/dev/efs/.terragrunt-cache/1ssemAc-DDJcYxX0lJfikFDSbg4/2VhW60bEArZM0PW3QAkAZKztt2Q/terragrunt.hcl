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
  source = "../../../../../Terraform/modules/efs/"
}

dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  efs_name                = "devopslogic-${local.environment}-efs"
  efs_security_group_name = "devopslogic-${local.environment}-efs-security-group"
  subnet                 = dependency.vpc.outputs.private_subnets[0]
  vpc_id                  = dependency.vpc.outputs.vpc_id
  allowed_cidr_blocks     = dependency.vpc.outputs.vpc_cidr_block

}
