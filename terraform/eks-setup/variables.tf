variable "project_name" {
  description = "project name"
  type = string
}

variable "aws_profile" {
  type = string
  description = "aws profile"
}

variable "region" {
  description = "AWS region"
  type = string
}

variable "cluster_name" {
  description = "AWS EKS cluster name"
  type = string
}

variable "tags" {
  description = "default tag for all AWS resources"
  type = map(string)
  default = {}
}
