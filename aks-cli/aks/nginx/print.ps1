param($index, $deployment)

WriteAndSetUsage "aks nginx print [index] [deployment]"

$namespace = "ingress"
CheckCurrentCluster
SetDefaultIfEmpty ([ref]$index) "1"
$nginxDeployment = GetNginxDeploymentName $deployment
KubectlCheckDaemonSet ([ref]$nginxDeployment) -namespace $namespace

Write-Info "Print Nginx config file from inside the container"

$pod = KubectlGetPod $nginxDeployment $namespace $index
KubectlCommand "exec -n $namespace $pod -- cat /etc/nginx/nginx.conf"