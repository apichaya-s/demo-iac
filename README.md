# demo-iac

# terraform/eks
# terraform/eks-setup
Setup EKS cluster with the related resources to run EKS like VPC, Subnets, etc. by following EKS Best Practices using any IaC tools (Bonus point: use Terraform/Terragrunt)

# terraform/sample-app
When the sample application deploys to EKS, they need to have access to
● S3 with permission GetObject, PutObject (S3 ARN:arn:aws:s3:::my-web-assets)
● SQS with permission; send, receive, delete message (SQS ARN:
arn:aws:sqs:ap-southeast-1:123456789123:lms-import-data)
● Condition: Avoid injecting the generated aws secret/access keys to the
application directly.
