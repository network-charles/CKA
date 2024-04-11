# Create a security group
resource "aws_security_group" "sg" {
  name        = "sg"
  vpc_id      = aws_vpc.K8s.id
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
    Name = "sg"
  }
}

#-------------------------------------------------------------------------------#
#             Cluster Node                                                      #
#-------------------------------------------------------------------------------#

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

#-------------------------------------------------------------------------------#
#              AWS Load Balancer Controller                                     #
#-------------------------------------------------------------------------------#
resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  policy = file("${path.module}/AWSLoadBalancerController.json")
  name   = "AWSLoadBalancerController"
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role_policy.json
  name               = "aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_attach" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}

#-------------------------------------------------------------------------------#
#            KeyPair                                                            #
#-------------------------------------------------------------------------------#

# Create a key_name for SSH 
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "myKey"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = <<-EOT
        echo '${tls_private_key.key.private_key_pem}' > ./myKey.pem
        
        # make myKey.pem readable
        chmod 400 myKey.pem
    EOT
  }
}
