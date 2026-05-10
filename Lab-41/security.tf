# Create two security groups
resource "aws_security_group" "cluster_1" {
  name        = "cluster_1"
  vpc_id      = aws_vpc.cluster_1.id
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cluster_1"
  }
}

resource "aws_security_group" "cluster_2" {
  provider = aws.eu-west-2
  name        = "cluster_2"
  vpc_id      = aws_vpc.cluster_2.id
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cluster_2"
  }
}

#------------------------------------------------------------------#
#                  ClusterNode                                     #
#------------------------------------------------------------------#

resource "aws_iam_role" "eks-iam-role" {
  name               = "eks-iam-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = data.aws_iam_policy.AmazonEKSClusterPolicy.arn
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role" "worker-nodes-iam-role" {
  name               = "worker-nodes-iam-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = data.aws_iam_policy.AmazonEKSWorkerNodePolicy.arn
  role       = aws_iam_role.worker-nodes-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = data.aws_iam_policy.AmazonEKS_CNI_Policy.arn
  role       = aws_iam_role.worker-nodes-iam-role.name
}

resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = data.aws_iam_policy.EC2InstanceProfileForImageBuilderECRContainerBuilds.arn
  role       = aws_iam_role.worker-nodes-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-Node" {
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn
  role       = aws_iam_role.worker-nodes-iam-role.name
}

# Create a key_name for SSH 
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "cluster_1_key_pair" {
  key_name   = "myKey"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = <<-EOT
        echo '${tls_private_key.key.private_key_pem}' > ./cluster_1_key.pem
        
        # make myKey.pem readable
        chmod 400 myKey.pem
    EOT
  }
}

resource "aws_key_pair" "cluster_2_key_pair" {
  key_name   = "myKey"
  public_key = tls_private_key.key.public_key_openssh
  provider = aws.eu-west-2

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = <<-EOT
        echo '${tls_private_key.key.private_key_pem}' > ./cluster_2_Key.pem
        
        # make myKey.pem readable
        chmod 400 myKey.pem
    EOT
  }
}