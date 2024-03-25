variable "project_name" {
  description = "project name"
  type        = string
}
variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "default tag for all AWS resources"
  type        = map(string)
  default     = {}
}

variable "aws_profile" {
  type        = string
  description = "aws profile"
}

variable "environment" {
  description = "application environment"
  type        = string
}
variable "namespace" {
  type        = string
  description = "k8s namespace"
}
variable "service" {
  type        = string
  description = "k8s deployment name"
}
