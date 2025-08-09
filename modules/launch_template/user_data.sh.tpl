Content-Type: application/node.eks.aws

apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: ${eks_cluster_name}
    apiServerEndpoint: ${eks_cluster_endpoint}
    certificateAuthority: ${eks_cluster_certificate}
    cidr: ${cluster_service_cidr}
