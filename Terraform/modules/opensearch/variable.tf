variable "domain" {
  type        = string
  default     = "cortado-staging-opensearch"
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "instance_type" {
  type    = string
  default = "c4.large.elasticsearch"
}
variable "tag_domain" {
  type    = string
  default = "cortado-staging"
}
variable "volume_type" {
  type    = string
  default = "gp2"
}
variable "ebs_volume_size" {
  default = 10

}
