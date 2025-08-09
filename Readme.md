# 🚀 AWS EKS Infrastructure with Terraform

## 📋 Overview
This repository contains Terraform code to provision a complete **Amazon Elastic Kubernetes Service (EKS)** environment on AWS.  
The setup includes VPC networking, subnets, IAM roles, security groups, EKS control plane, worker nodes, and supporting resources.

The infrastructure is **modular** — each AWS component is encapsulated in its own Terraform module for reusability and better management.

---

## 🏗 Architecture
The architecture includes:

- **VPC** with public and private subnets
- **Internet Gateway & NAT Gateway** for outbound connectivity
- **Security Groups** for controlling access
- **IAM Roles & Policies** for EKS and EC2
- **EKS Cluster** control plane
- **EKS Managed Node Groups** (via Launch Templates)
- **EKS Add-ons** (CoreDNS, kube-proxy, VPC CNI, etc.)
- **aws-auth ConfigMap** for RBAC mapping

---

## 📂 Project Structure

```plaintext
.
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── network/                # Route tables, IGW, NAT
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── iam/                     # Roles, Policies
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── eks-cluster/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── launch_template/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── nodegroup/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   └── aws_auth/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│
├── main.tf                      # Root module calling all submodules
├── variables.tf
├── outputs.tf
├── terraform.tfvars             # Environment-specific values
├── provider.tf                  # AWS provider & backend config
├── versions.tf                  # Terraform & provider version constraints
└── README.md
