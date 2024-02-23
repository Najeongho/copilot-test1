# Output the cluster name
output "cluster_name" {
  value = aws_eks_cluster.my_cluster.name
}
