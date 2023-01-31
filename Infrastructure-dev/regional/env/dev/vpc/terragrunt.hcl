include {
    path = find_in_parent_folders()
}


locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.environment_vars.locals.environment
 # cluster_name = local.region_vars.locals.cluster_name
  cluster_name = "devopslogic-dev"

}

terraform {
    source = "../../../../../Terraform/modules/terraform-aws-vpc/"
}

inputs = {
  name = "${local.environment}-eks-vpc"

  cidr = "10.0.0.0/16"
  azs  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/18"]
  public_subnets  = ["10.0.192.0/20", "10.0.208.0/20", "10.0.224.0/20"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
