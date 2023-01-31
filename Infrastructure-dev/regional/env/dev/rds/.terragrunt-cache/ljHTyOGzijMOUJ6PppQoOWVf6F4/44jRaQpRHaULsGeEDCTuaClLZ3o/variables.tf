variable "db_subnet_grpup_name" {
  default = "db_subnet_group"

}

variable "vpc_id" {
  default = ""
}

#variable "subnets_ids" {
#}

variable "subnet1" {}
variable "subnet2" {}

variable "db_security_group_name" {
  default = ""

}

variable "db_security_group_name_desc" {
  default = "security-group-for-RDS"

}

variable "db_indentifier" {
  type    = string
  default = ""
}
variable "rds_instance_type" {
  type    = string
  default = "value"
}

variable "storage_in_db" {
  type    = number
  default = 50
}

variable "database_engine" {
  default = "mysql"

}

variable "database_engine_version" {
  default = "8.0"
}

variable "db_username" {
  type    = string
  default = "root"

}

variable "db_password" {
  type    = string
  default = ""

}

variable "parameter_group_name" {
  type    = string
  default = ""
}

variable "allowed_cidr_blocks" {
  default     = ["10.2.0.0/16"]
  description = "The whitelisted CIDRs which to allow `ingress` traffic to LB"
}


variable "bastion_cidr_blocks" {
  default = ["10.2.0.0/16"]

}
variable "public_access" {
  default = false

}

variable "skip_final_snapshot" {
  default = true

}


variable "multi_az" {
  default = true
}


variable "apply_immediately" {
  default = false
}
