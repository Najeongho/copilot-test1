


# Create a security group for EKS
resource "aws_security_group" "eks_security_group" {
  name        = "eks-security-group"
  description = "Security group for EKS cluster"

  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for EKS node group
resource "aws_security_group" "eks_nodegroup_security_group" {
  name        = "eks-nodegroup-security-group"
  description = "Security group for EKS node group"

  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

