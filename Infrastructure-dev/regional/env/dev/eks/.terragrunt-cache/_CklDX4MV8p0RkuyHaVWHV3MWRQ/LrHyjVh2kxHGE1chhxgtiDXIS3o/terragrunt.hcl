include {
  path = find_in_parent_folders()
}


locals {
  # Automatically load region-level variables and also auth config is setup right at the bottom.
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment      = local.environment_vars.locals.environment
  cluster_name     = "devopslogic-dev"
  instance_size    = "t3.medium"

}


terraform {
  source = "../../../../../Terraform/modules/terraform-aws-eks/"
}

dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  cluster_name                    = local.cluster_name
  cluster_version                 = "1.22"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  enable_irsa = true
  vpc_id                          = dependency.vpc.outputs.vpc_id
  vpc_cidr_blocks                 = dependency.vpc.outputs.vpc_cidr_block
  subnet_ids                      = dependency.vpc.outputs.private_subnets
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_group_defaults = {
    ami_type             = "AL2_x86_64"
    key_name             = "devopslogic-dev"
    launch_template_name = "devopslogic-dev"
    #attach_cluster_primary_security_group = true
    # Disabling and using externally provided security groups
    #create_security_group = false
  }

  eks_managed_node_groups = {
    one = {
      name                   = "dev-node-group-1"
      instance_types         = ["${local.instance_size}"]
      min_size               = 2
      key_name               = "devopslogic-dev"
      max_size               = 15
      desired_size           = 3
      vpc_security_group_ids = ["${dependency.vpc.outputs.node_group_one}"]
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 40
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 125
            encrypted             = true
            delete_on_termination = true
          }
        }
      }
    }

    two = {
      name                   = "dev-node-group-2"
      key_name               = "devopslogic-dev"
      instance_types         = ["${local.instance_size}"]
      min_size               = 2
      max_size               = 15
      desired_size           = 3
      vpc_security_group_ids = ["${dependency.vpc.outputs.node_group_two}"]
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 40
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 125
            encrypted             = true
            delete_on_termination = true
          }
        }
      }
    }
  }
}
