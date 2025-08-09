resource "aws_security_group" "ekssg" {
  name        = "${terraform.workspace}-${var.security_group_name}"
  vpc_id      = var.vpc_id
  description = "Security Group for EKS nodes"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # You should restrict this in production
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "EKS Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    security_groups = [aws_security_group.ALBSG.id]
  }
  ingress {
    description = "EKS Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Node Port Range"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${terraform.workspace}-EKS"
    Environment = "${terraform.workspace}"
    App         = "EKS"
  }
}

resource "aws_security_group" "ALBSG" {
  name        = "${terraform.workspace}-${var.ALB_sg_name}"
  vpc_id      = var.vpc_id
  description = "Security Group for Application Load Balancer"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${terraform.workspace}-ALBSG"
    Environment = "${terraform.workspace}"
    App         = "ALB"
  }
}


resource "aws_security_group" "eks_cluster_sg" {
  name        = "${terraform.workspace}-eks-cluster-sg"
  description = "EKS control plane security group"
  vpc_id      = var.vpc_id

  ingress {
    description              = "Allow worker nodes to communicate with control plane"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    security_groups          = [aws_security_group.ekssg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
