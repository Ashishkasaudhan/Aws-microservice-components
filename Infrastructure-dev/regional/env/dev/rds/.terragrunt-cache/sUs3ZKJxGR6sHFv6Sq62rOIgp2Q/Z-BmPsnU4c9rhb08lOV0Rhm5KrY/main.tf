resource "aws_db_subnet_group" "dbsubnet" {
  name       = var.db_subnet_grpup_name
  subnet_ids = [var.subnet1, var.subnet2]
}

resource "aws_security_group" "rds" {
  name        = var.db_security_group_name
  description = var.db_security_group_name_desc
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.bastion_cidr_blocks}"]
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.db_security_group_name
  }
}


resource "aws_db_instance" "onehub" {
  identifier             = var.db_indentifier
  instance_class         = var.rds_instance_type
  allocated_storage      = var.storage_in_db
  engine                 = var.database_engine
  engine_version         = var.database_engine_version
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.dbsubnet.name
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  parameter_group_name   = var.parameter_group_name
  publicly_accessible    = var.public_access
  skip_final_snapshot    = var.skip_final_snapshot
  multi_az               = var.multi_az
  apply_immediately      = var.apply_immediately
}
