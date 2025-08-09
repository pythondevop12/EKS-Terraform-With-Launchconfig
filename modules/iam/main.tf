resource "aws_iam_role" "eks_role" {
  name               = "${terraform.workspace}-${var.cluster_role_name}"
  assume_role_policy = data.aws_iam_policy_document.eks_policy.json
  tags = {
    "Name"        = "${terraform.workspace}-EKSClusterole"
    "Environment" = "${terraform.workspace}"
  }
}


data "aws_iam_policy_document" "eks_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}


resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment" {
  name = "${var.cluster_role_name}"
  roles       = [aws_iam_role.eks_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_iam_role" "node_role" {
  name               = "${terraform.workspace}-${var.node_role_name}"
  assume_role_policy = data.aws_iam_policy_document.node_policy.json
    tags = {
    "Name"        = "${terraform.workspace}-NodeRole"
    "Environment" = "${terraform.workspace}"
  }

}


data "aws_iam_policy_document" "node_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }

}

resource "aws_iam_role_policy_attachment" "worker_node_policy_attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ])
  role       = aws_iam_role.node_role.name
  policy_arn = each.value
}


resource "aws_iam_user" "eks_admin" {
  name = "${terraform.workspace}-eks-admin"
  tags = {
    Environment = terraform.workspace
  }
}

resource "aws_iam_user_policy_attachment" "eks_admin_attach" {
  user       = aws_iam_user.eks_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


