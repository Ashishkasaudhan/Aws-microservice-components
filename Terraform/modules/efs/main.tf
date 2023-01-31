resource "aws_efs_file_system" "efs" {
   creation_token = var.efs_name
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = var.efs_name
   }
 }


resource "aws_security_group" "efs" {
  name        = var.efs_security_group_name
  description = var.efs_security_group_name_desc
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 2049
    to_port     =  2049
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

  tags = {
    Name = var.efs_security_group_name
  }
}

resource "aws_efs_mount_target" "efs-mt" {
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = var.subnet
   security_groups = [aws_security_group.efs.id]
 }

 
