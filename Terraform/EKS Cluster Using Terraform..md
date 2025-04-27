---
title: EKS Cluster Using Terraform.
source: https://abhishekverma109.hashnode.dev/eks-cluster-using-terraform?source=more_articles_bottom_blogs
author:
  - "[[Abhishek Verma]]"
published: 2023-01-28
created: 2024-12-16
description: IntroductionCreating an Amazon Elastic Kubernetes Service (EKS) cluster can be a complex task, but using Terraform simplifies the process and allows for easy management and scaling of the cluster. In this blog post, we will walk through the process ...
tags:
  - Terraform
---
## [Permalink](https://abhishekverma109.hashnode.dev/?source=more_articles_bottom_blogs#heading-introduction "Permalink")**Introduction**

Creating an Amazon Elastic Kubernetes Service (EKS) cluster can be a complex task, but using Terraform simplifies the process and allows for easy management and scaling of the cluster. In this blog post, we will walk through the process of creating an EKS cluster using Terraform, and provide tips and best practices for working with EKS and Terraform.

### [Permalink](https://abhishekverma109.hashnode.dev/?source=more_articles_bottom_blogs#heading-why-eks-a-great-choice-for-running-kubernetes-clusters-on-aws "Permalink")Why EKS a great choice for running Kubernetes clusters on AWS?

EKS is a managed Kubernetes service that makes it easy to deploy, scale, and manage containerized applications using Kubernetes. It eliminates the need to provision and manage the underlying infrastructure, and allows for easy scaling of the cluster.

### [Permalink](https://abhishekverma109.hashnode.dev/?source=more_articles_bottom_blogs#heading-benefits-of-using-terraform-to-create-an-eks-cluster "Permalink")Benefits of using Terraform to create an EKS cluster.

One of the main benefits is the ability to version control infrastructure, which allows for easy rollbacks in case of errors or issues. Additionally, Terraform allows for easy management of the cluster by making it easy to make changes to the cluster and automate the provisioning process.

Before we dive into the process of creating an EKS cluster using Terraform, there are a few prerequisites that must be met:

- AWS account
- IAM user with necessary permissions
- Terraform version v1.1.9 or later
- AWS CLI version 2 or later

Now, let's start by setting up the necessary AWS resources. We will create a VPC and Subnet using Terraform. Here is an example of how to create a VPC and Subnet using Terraform:

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674905131694/529df2be-82c3-4386-ae05-7ed3fc8c32bf.png?auto=compress,format&format=webp)

"[kubernetes.io/cluster/eks](http://kubernetes.io/cluster/eks)" = "shared" and "[kubernetes.io/role/elb](http://kubernetes.io/role/elb)" = 1 these tags are provided as they allow eks to discover particular subnet and use these subnets for launching load balancer.

Creating NAT Gateway to provide internet access for private subnets.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674905228785/36d62752-cecd-4369-8358-4c36cdea54a3.png?auto=compress,format&format=webp)

Creating rules in the Routing table and attaching them to the subnet.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674905307184/dcebadc6-6308-40b8-9b09-d9e48ca4985d.png?auto=compress,format&format=webp)

Creating a role for EKS, attaching it to the cluster and creating cluster name "eks".

```
resource "aws_iam_role" "eks_role" 
  name = "eks_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  # The ARN of the policy you want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  # The role to which  policy should be applied 
  role = aws_iam_role.eks_role.name
}
resource "aws_eks_cluster" "eks" {
  # Name of the cluster.
  name = "eks"
  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for 
  # the Kubernetes control plane to make calls to AWS API operations on your behalf
  role_arn = aws_iam_role.eks_role.arn
  # Desired Kubernetes master version
  version = "1.24"
  vpc_config {
    # Indicates whether or not the Amazon EKS private API server endpoint is enabled
    endpoint_private_access = false
    # Indicates whether or not the Amazon EKS public API server endpoint is enabled
    endpoint_public_access = true
    # Must be in at least two different availability zones
    subnet_ids = [
      aws_subnet.public-subnet.id,
      aws_subnet.private-subnet.id,

    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}
```

Creating a role for the Node group and attaching it to the Node Group with two nodes.

```
# Create IAM role for EKS Node Grou
resource "aws_iam_role" "worker_nodes_role" {
  name = "worker_nodes_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
# Resource: aws_iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  # The ARN of the policy you want to apply.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  # The role the policy should be applied to
  role = aws_iam_role.worker_nodes_role.name
}
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.worker_nodes_role.name
}
resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.worker_nodes_role.name
}

# Resource: aws_eks_node_group
resource "aws_eks_node_group" "worker_nodes" {
  # Name of the EKS Cluster.
  cluster_name = aws_eks_cluster.eks.name

  # Name of the EKS Node Group.
  node_group_name = "worker_nodes"

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = aws_iam_role.worker_nodes_role.arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids = [
    aws_subnet.private-subnet.id,
    aws_subnet.private-subnet.id
  ]

  # Configuration block with scaling settings
  scaling_config {
    # Desired number of worker nodes.
    desired_size = 2

    # Maximum number of worker nodes.
    max_size = 3

    # Minimum number of worker nodes.
    min_size = 1
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group. 
  # Valid values: ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  # Disk size in GiB for worker nodes
  disk_size = 5

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false

  # List of instance types associated with the EKS Node Group
  instance_types = ["t2.micro"]

  labels = {
    role = "worker_nodes"
  }

  # Kubernetes version
  version = "1.24"

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only,
  ]
}
```

Now, creating creating cluster using this terraform code.

```
 # terraform init cmd to initialize the working 
 terraform init
 # terraform apply to create required  infrastructure
 terraform apply
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674905960791/7c760b3d-c25d-40a5-879a-d18165278991.png?auto=compress,format&format=webp)

When you use terraform to create a cluster, you need to update your Kubernetes context manually.

```
aws eks update-kubeconfig --name eks --region ap-south-1
```

Then checking our nodes

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674906067387/a272f54f-be5c-4f7f-b5be-e180b53b9e03.png?auto=compress,format&format=webp)

### [Permalink](https://abhishekverma109.hashnode.dev/?source=more_articles_bottom_blogs#heading-deploying-app-on-kubernetes "Permalink")Deploying App on Kubernetes

File to deploy an app on Kubernetes

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674906215851/0ec163ec-d38b-4f7e-b5c5-264941218e34.png?auto=compress,format&format=webp)

Now exposing our app with NLB one in private subnet and one public subnet.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674906281454/4defda60-db0d-42c8-a164-cb285d261fe1.png?auto=compress,format&format=webp)

Checking our service.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674906502591/e8a78f5b-361c-4aa2-80da-fbc91d74855e.png?auto=compress,format&format=webp)

Our app exposes on external-lb.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674906593144/c8077304-214e-4cc3-b14b-574b61d6e082.png?auto=compress,format&format=webp)

Thank you for reading.