variable "efs_name" {
  default = ""
  
}

variable "vpc_id" {
  default = ""
  
}
variable "subnet"{}

variable "efs_security_group_name" {
  default = ""
  
}

variable "efs_security_group_name_desc" {
  default = "security-group-for-EFS"
  
}



variable "allowed_cidr_blocks" {
  default     = ["10.2.0.0/16"]
  description = "The whitelisted CIDRs which to allow `ingress` traffic to LB"
}


