locals{
  cls_autoscaler_sa_ns = "kube-system"
  cls_autoscaler_sa_name = "cluster-autoscaler"
}

data "aws_iam_policy_document" "cluster_autoscaler" {
  statement {
    sid       = "AllowTriggerAutoScalingGroup"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes",
      "eks:DescribeNodegroup",
    ]
  }
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "${var.cluster_name}-cluster-autoscaler-serviceaccount-policy"
  path        = "/"
  policy = data.aws_iam_policy_document.cluster_autoscaler.json
}

module "cluster_autoscaler_sa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "${var.cluster_name}-${local.cls_autoscaler_sa_name}-role"
  role_policy_arns = {
    policy = aws_iam_policy.cluster_autoscaler.arn
  }

  oidc_providers = {
    one = {
      provider_arn               = local.oidc_provider_arn
      namespace_service_accounts = ["${local.cls_autoscaler_sa_ns}:${local.cls_autoscaler_sa_name}"]
    }
  }
}

resource "helm_release" "cluster_autoscaler" {
  # https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  // atomic    = true
  timeout   = 60
  namespace = local.cls_autoscaler_sa_ns
  values = [
    yamlencode({
      replicas          = "2"
      priorityClassName = "system-cluster-critical"
      rbac = {
        serviceAccount = {
          name = local.cls_autoscaler_sa_name
          annotations = {
            "eks.amazonaws.com/role-arn" = module.cluster_autoscaler_sa.iam_role_arn
          }
        }
      }
      awsRegion = var.region
      autoDiscovery = {
        clusterName = data.aws_eks_cluster.cluster.name
      }
      extraArgs = {
        skip-nodes-with-local-storage    = "false"
        skip-nodes-with-system-pods      = "false"
        balance-similar-node-groups      = "true"
      }
    })
  ]
}
