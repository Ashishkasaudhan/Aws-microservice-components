
resource "aws_cloudwatch_log_group" "example" {
  name = var.aws_cloudwatch_log_group_name

  tags = {
    Environment = "${var.environment}"
    Application = "${var.application_name}"
  }
}

resource "aws_security_group" "elastic_cache" {
  name        = "elastic-cache-sg"
  description = "security group for elastic cache"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#  tags = {
#    Name = var.ec_security_group_name
#  }
}

resource "aws_elasticache_subnet_group" "default" {
  name        = var.subnet_group_name
  subnet_ids  = [var.subnet1, var.subnet2, var.subnet3]
  description = "${var.environment}-elastic-group"
}
resource "aws_elasticache_cluster" "onehub" {
  cluster_id         = var.cluster_id
  engine             = var.engine_type
  node_type          = var.node_type
  num_cache_nodes    = var.num_cache_nodes
  port               = var.port
  subnet_group_name  = var.subnet_group_name
  security_group_ids = [aws_security_group.elastic_cache.id]
  apply_immediately  = true
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.example.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
  depends_on = [aws_elasticache_subnet_group.default]
}
