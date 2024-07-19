resource "aws_security_group" "eks" {
    name        = "${var.cluster_name}"
    description = "Allow traffic"
    vpc_id      = aws_vpc.vpc.id

    ingress {
      description      = "World"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
      Name = "${var.prefix}-sg"
    }
  }

  module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "18.19.0"

    cluster_name                    = "${var.cluster_name}"
    cluster_version                 = "1.29"
    cluster_endpoint_private_access = true
    cluster_endpoint_public_access  = true
    cluster_additional_security_group_ids = [aws_security_group.eks.id]

    vpc_id     = aws_vpc.vpc.id
    subnet_ids = concat(aws_subnets.private-subnets.*.id, aws_subnets.public-subnets.*.id)

    eks_managed_node_group_defaults = {
      ami_type               = "AL2_x86_64"
      disk_size              = 50
      instance_types         = ["t3.micro", "t3.micro"]
      vpc_security_group_ids = [aws_security_group.eks.id]
    }

    eks_managed_node_groups = {
      iburguer = {
        min_size     = 1
        max_size     = 10
        desired_size = 5

        instance_types = ["t3.micro"]
        capacity_type  = "SPOT"
        taints = {
        }
      }
    }
  }
  