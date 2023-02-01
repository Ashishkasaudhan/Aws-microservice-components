output "efs" {
  description = "name of efs cluster with arn"
  value       = aws_efs_file_system.efs.arn
}
output "efs_id" {
  description = "address of efs id"
  value       = aws_efs_file_system.efs.id
}
