
locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  aws_region   = local.region_vars.locals.aws_region
}

# Generate an AWS provider block
generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
    backend = "s3"
    config = {
        encrypt        = true
        bucket         = "devopslogic-terraform-tfstate"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        region         = local.aws_region
        # For locking purposes, we need to create a dynamodb table
        # dynamodb_table = "terraform-locks"
    }
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}

# GLOBAL PARAMETERS
inputs = merge(
  local.region_vars.locals,
  local.environment_vars.locals,
)
