# Create an EKS cluster
resource "aws_eks_cluster" "my_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.my_cluster_role.arn
  version  = "1.25" # Replace with your desired EKS version

  vpc_config {
    subnet_ids         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id] # Replace with your desired subnet IDs
    endpoint_public_access = true
    endpoint_private_access = false
    security_group_ids = [aws_security_group.eks_security_group.id, aws_security_group.eks_nodegroup_security_group.id]
    
  }
}



# Create an EKS Nodegroup
resource "aws_eks_node_group" "my_nodegroup" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "test-eks-nodegroup"
  node_role_arn   = aws_iam_role.my_nodegroup_role.arn
  subnet_ids      = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }
  instance_types = ["t3a.medium"] # Replace with your desired instance type
  ami_type       = "AL2_x86_64"   # Replace with your desired AMI type
  disk_size      = 20              # Replace with your desired EBS disk size in GB
  capacity_type = "ON_DEMAND"


}

