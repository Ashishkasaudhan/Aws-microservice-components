# Introduction
This repository holds the code to provision the following AWS services, which are required to build an Microservices based environment. We are following 3 tier architecture approch. 

1. VPC
2. EKS
3. RDS
4. ElastiCache
5. Opensearch-Service
6. EFS


## Ref-Link
#### [Amazon EKS](https://aws.amazon.com/eks/)
#### [Amazon VPC](https://aws.amazon.com/vpc/)
#### [Amazon RDS](https://aws.amazon.com/rds/)
#### [Amazon elasticache](https://aws.amazon.com/elasticache/)
#### [Amazon opensearch-service](https://aws.amazon.com/opensearch-service/)
#### [Amazon efs](https://aws.amazon.com/efs/)
**_Note: For VPC and EKS Module, We have taken reference from official terraform registry._**

___
We are using **Terragrunt** as IAC tool.
The initial purpose of Terragrunt was to fill in a few gaps in Terraform’s functionality, and it has continuously expanded with new features. The main benifit Terragrunt provides is the de-coupling of terraform module along with state files.Each Services used in this solution having its own state file. Terragrunt brings the following rich feature set to the table:

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

<img width="400" alt="image" src="https://user-images.githubusercontent.com/12654660/215961433-c23fce85-e272-4773-aaa9-1de182ec98a0.png">

____
## Execution Steps
1. Clone the git repo.
2. Go To Infrastructure-dev and open the terragrunt.hcl file.
3. Provide the S3 bucket name, which holds the state files for our services
<img width="400" alt="image" src="https://user-images.githubusercontent.com/12654660/215960510-0c84df45-83d5-4338-bb33-aafe8f1509f3.png">
4. Go To Infrastructure-dev/regional Folder and Open the region.hcl file.
5. Provide the Region name, where we wants to provision our infrastructure.Make Sure S3 Bucket should also exsist into same region or if you want to have s3 bucket in a different region, change the local values in terragrunt.hcl file mentioned in step 2.
<img width="400" alt="image" src="https://user-images.githubusercontent.com/12654660/215961125-814c927a-ebc1-4f52-9ad3-4cfa36dbad2f.png">
6. Go To Infrastructure-dev/regional/env Folder and Open the env.hcl file.
7. Provide the environment name, which is nothing but a variable used in resource creation. You can leverage these file to use more common variable as per your use case.
<img width="400" alt="image" src="https://user-images.githubusercontent.com/12654660/215961896-f47e40b9-1223-469a-9bca-152fba520c10.png">
8. Now go to Infrastructure-dev/regional/env/vpc Folder and Open the terragrunt.hcl file and provide/replace the values accordingly. 

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


# commands to create the above resources:
Note: You need to install the latest version of terragrunt
1. Git clone this repo to your workstation
2. cd Infrastructure-(env)/regional/env/(env)
3. run terragrunt run-all plan 
4. run terragrunt run-all apply

You can also create or update individual resources by going to that resource specific directory under staging on production folder and run terragrunt plan and terragrunt apply commands.

All the statefiles are store in s3 bucket.
