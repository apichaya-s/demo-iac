resource "helm_release" "metrics_server" {
  # https://github.com/kubernetes-sigs/metrics-server
  # priorityClassName: system-cluster-critical
  name = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"

  atomic    = true
  timeout    = 60
  namespace  = "kube-system"
}
