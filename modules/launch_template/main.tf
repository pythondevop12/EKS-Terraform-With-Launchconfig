resource "aws_launch_template" "eks_launch_template" {
  name                   = var.launch_template
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_ids] # No brackets if already a list

  user_data = base64encode(
    templatefile("${path.module}/user_data.sh.tpl", {
      eks_cluster_name        = var.eks_cluster_name,
      eks_cluster_endpoint    = var.eks_cluster_endpoint,
      eks_cluster_certificate = var.eks_cluster_certificate,
      cluster_service_cidr    = var.cluster_service_cidr
    })
  )


  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 2
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name"                                          = "${terraform.workspace}-eksnode"
      "Environment"                                   = "${terraform.workspace}"
      "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
      "eks:cluster-name"                              = var.eks_cluster_name
      "eks:nodegroup-name"                            = "${terraform.workspace}-ng"
    }
  }
}
