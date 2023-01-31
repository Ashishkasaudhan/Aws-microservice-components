resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain
  elasticsearch_version = "OpenSearch_1.3"

  cluster_config {
    instance_type = var.instance_type
  }
  snapshot_options {
    automated_snapshot_start_hour = 23
  }
  ebs_options {
    ebs_enabled = true
    volume_size = var.ebs_volume_size
    volume_type = var.volume_type
  }
  tags = {
    Domain = var.tag_domain
  }
}

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name     = aws_elasticsearch_domain.es.domain_name
  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "${aws_elasticsearch_domain.es.arn}/*"
        }
    ]
}
POLICIES
}

