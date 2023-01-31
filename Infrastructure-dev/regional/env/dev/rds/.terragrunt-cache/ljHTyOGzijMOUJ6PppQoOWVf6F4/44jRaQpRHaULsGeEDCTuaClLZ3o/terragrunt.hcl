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
  source = "../../../../../Terraform/modules/rds/"
}

dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  db_subnet_grpup_name   = "devopslogic-${local.environment}-db-subnet-group"
  db_security_group_name = "devopslogic-${local.environment}-rds-security-group"
  db_indentifier         = "devopslogic-${local.environment}"
  rds_instance_type      = "db.t3.micro"
  storage_in_db          = 40
  database_engine        = "mysql"
  db_username            = "root"
  db_password            = ".TrzmKJe-4yKsnqTMEcjwkgG"
  parameter_group_name   = "default.mysql8.0"
  subnet1                = dependency.vpc.outputs.private_subnets[0]
  subnet2                = dependency.vpc.outputs.private_subnets[1]
  vpc_id                 = dependency.vpc.outputs.vpc_id
  allowed_cidr_blocks = dependency.vpc.outputs.vpc_cidr_block
  bastion_cidr_blocks = "10.0.193.234/32"
  apply_immediately   = true
}
