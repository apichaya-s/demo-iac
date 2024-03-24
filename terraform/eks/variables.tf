variable "project_name" {
  description = "project name"
  type = string
}

variable "cluster_version" {
  description = "AWS EKS version"
  type = string
}

variable "region" {
  description = "AWS region"
  type = string
}


variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "tags" {
  description = "default tag for all AWS resources"
  type = map(string)
  default = {}
}

variable "aws_profile" {
  type = string
  description = "aws profile"
}
