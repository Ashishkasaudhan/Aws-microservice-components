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

We are using **Terragrunt** as IAC tool.
The initial purpose of Terragrunt was to fill in a few gaps in Terraform’s functionality, and it has continuously expanded with new features. Although Terraform has evolved to support more advanced feature sets, it still has room for improvement. Only Terragrunt brings the following rich feature set to the table:

* Explicit dependencies: Share your state easily
* Automatic Atlantis config generation: Eliminates toil
* Environment variable support: Discourages hard-coded values
* Generate blocks: Remove repeated Terraform
* Automatic resource tagging: Applies metadata universally
* Arbitrary command output from variables: Streamlines library usage
* read_terragrunt_config imports: Eliminate repeated Terragrunt code

You can read more about terragrunt from here: (https://terragrunt.gruntwork.io/)


# commands to create the above resources:
Note: You need to install the latest version of terragrunt
1. Git clone this repo to your workstation
2. cd Infrastructure-(env)/regional/env/(env)
3. run terragrunt run-all plan 
4. run terragrunt run-all apply

You can also create or update individual resources by going to that resource specific directory under staging on production folder and run terragrunt plan and terragrunt apply commands.

All the statefiles are store in s3 bucket.
