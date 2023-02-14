# Introduction
This repository holds the code to provision the following AWS services, which are required to build an Microservices based environment. 
1. VPC
2. EKS (Kubernetes Engine)
3. RDS
4. Elastic Cache 
5. EFS ( As An Storage Class)


## Ref-Link
#### [Amazon EKS](https://aws.amazon.com/eks/)
#### [Amazon VPC](https://aws.amazon.com/vpc/)
#### [Amazon RDS](https://aws.amazon.com/rds/)
#### [Amazon elasticache](https://aws.amazon.com/elasticache/)
#### [Amazon efs](https://aws.amazon.com/efs/)
**_Note: For VPC and EKS Module, We have taken reference from official terraform registry._**

___
We are using **Terragrunt** as IAC tool.
The initial purpose of Terragrunt was to fill in a few gaps in Terraform’s functionality, and it has continuously expanded with new features. The main benefit Terragrunt provides is the de-coupling of terraform module along with state files. Each Services used in this solution having its own state file. Terragrunt brings the following rich feature set to the table:

* Explicit dependencies: Share your state easily
* Automatic Atlantis config generation: Eliminates toil
* Environment variable support: Discourages hard-coded values
* Generate blocks: Remove repeated Terraform
* Automatic resource tagging: Applies metadata universally
* Arbitrary command output from variables: Streamlines library usage
* read_terragrunt_config imports: Eliminate repeated Terragrunt code

You can read more about terragrunt from here: (https://terragrunt.gruntwork.io/)
____
## Pre-Requisites
* An AWS Account
* An IAM role or User with Proper Permission to provision Requested Resources. 
* terragrunt version v0.35.8
* Terraform v1.2.9
____

## Terragrunt File Structure

<img width="1200" alt="image" src="https://user-images.githubusercontent.com/12654660/215961433-c23fce85-e272-4773-aaa9-1de182ec98a0.png">

____
## Execution Steps
1. Clone the git repo.
2. Go to Infrastructure-dev and open the terragrunt.hcl file.
3. Provide the S3 bucket name, which holds the state files for our services
<img width="800" alt="image" src="https://user-images.githubusercontent.com/12654660/215960510-0c84df45-83d5-4338-bb33-aafe8f1509f3.png">

4. Go To Infrastructure-dev/regional Folder and Open the region.hcl file.

5. Provide the Region name, where we wants to provision our infrastructure.Make Sure S3 Bucket should also exsist into same region or if you want to have s3 bucket in a different region, change the local values in terragrunt.hcl file mentioned in step 2.

<img width="500" alt="image" src="https://user-images.githubusercontent.com/12654660/215961125-814c927a-ebc1-4f52-9ad3-4cfa36dbad2f.png">

6. Go to Infrastructure-dev/regional/env Folder and Open the env.hcl file.

7. Provide the environment name, which is nothing but a variable used in resource creation. You can leverage these files to use more common variable as per your use case.
<img width="500" alt="image" src="https://user-images.githubusercontent.com/12654660/215961896-f47e40b9-1223-469a-9bca-152fba520c10.png">

8. Now go to Infrastructure-dev/regional/env/vpc Folder and Open the terragrunt.hcl file and provide/replace the values accordingly.

**_Note: Vpc is required for all the services which we are creating, so we provision vpc first. There are ways to provision all resource at same time but we are not covering that use case. Image mentioned below will explain you about vpc dependencies_**

![terrragrunt-graph-dependency](https://user-images.githubusercontent.com/12654660/215965999-3e055a47-d071-4528-8626-3d15349ea489.png)



```
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

```
9. Run Terragrunt plan
<pre><code>terragrunt plan </pre></code>
10. Run Terragrunt apply 
<pre><code>terragrunt apply </pre></code>

<img width="800" alt="image" src="https://user-images.githubusercontent.com/12654660/215963449-42e67acc-cef0-43cb-8e76-0c562d5c52ca.png">
11. Wait for Vpc to get created first. 

12. After successful vpc creation, now we can provision all other resources at same time. This is a nice feature offered by terragrunt, but before that lets create each service specific **terragrunt.hcl** file.

13. Let’s Modify the Infrastructure-dev/regional/env/eks terragrunt.hcl file which is going to create an EKS cluster.
    **Go inside Infrastructure-dev/regional/env/dev/eks and change the values under locals and input section as per your environment.** 


```
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
  config_path = "../vpc"   -- We are using output from this dependency block to refer values for other variables used in this code.
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


```

14. Follow the steps mentioned in step 13 and modify the input and locals values in terragrunt.hcl for efs, elastic_cache, rds services folder's, which are present in Infrastructure-dev/regional/env/dev/.
![image](https://user-images.githubusercontent.com/12654660/218714021-d09f24e9-bdf4-47ca-a752-e109e3f814de.png)


16. Once you are done with your changes, then change the directory to Infrastructure-dev/regional/env/dev.
17. Now run terragrunt run-all plan command 
<pre><code>terragrunt run-all plan</pre></code>
![terragrunt-run-all](https://user-images.githubusercontent.com/12654660/215965347-0837cb38-1c20-4a62-84ff-1dc7eb50e97b.png)

17. validate your changes and run terragrunt run-all apply command
<pre><code>terragrunt run-all apply</pre></code>
![terragrunt run-all ](https://user-images.githubusercontent.com/12654660/215965577-f11ee8b3-a7cb-4f9c-818d-9755f1ca22ac.png)

18. Wait for All Resources to get created.
![terragrunt-cluster-creation](https://user-images.githubusercontent.com/12654660/215965768-dbebeba0-b631-4b6c-9993-e374abed9c2a.png)
![eks-node-group](https://user-images.githubusercontent.com/12654660/215965778-2fcd07ab-0bee-4a47-adb3-a234de6883da.png)

19. After sucessful execution of terragrunt run-all apply command, our state files for each service will be present on s3 bucket similar to this.
![terrragrunt-s3](https://user-images.githubusercontent.com/12654660/215966231-af6326b8-1510-4895-b149-616842c59fde.png)


## Cleanup
1. First run terragrunt run-all destroy --terragrunt-exclude-dir vpc from Infrastructure-dev/regional/env/dev directory, as vpc is added as dependency.
<pre><code>terragrunt run-all destroy --terragrunt-exclude-dir vpc</pre></code>
2. Once the destruction of all services service has been completed, then change the directory into Infrastructure-dev/regional/env/dev/vpc and run the terragrunt destroy command.
<pre><code>terragrunt destroy </pre></code>

## Useful Terragrunt command 
*  terragrunt show will provide you the output values for respective service.

*  terragrunt graph-dependencies will provide dependencies graph between terragrunt modules.
