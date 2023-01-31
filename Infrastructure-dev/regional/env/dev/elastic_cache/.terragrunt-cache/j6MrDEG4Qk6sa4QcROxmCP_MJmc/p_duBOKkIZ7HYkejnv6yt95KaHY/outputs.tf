output "cluster_arn" {
  description = "name of elastic cache cluster with arn"
  value       = aws_elasticache_cluster.onehub.arn
}
output "cluster_address" {
  description = "address of elastic cache cluster with arn"
  value       = aws_elasticache_cluster.onehub.cluster_address
}
