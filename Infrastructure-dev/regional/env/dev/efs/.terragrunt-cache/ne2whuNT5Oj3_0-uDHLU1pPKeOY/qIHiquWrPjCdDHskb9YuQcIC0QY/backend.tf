# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket  = "devopslogic-terraform-tfstate"
    encrypt = true
    key     = "regional/env/dev/efs/terraform.tfstate"
    region  = "us-east-1"
  }
}
