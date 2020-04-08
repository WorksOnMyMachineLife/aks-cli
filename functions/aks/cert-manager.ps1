param($subCommand)

$subCommands=@{
    "install" = "Install Certificate Manager (Helm chart).";
    "logs" = "Get Nginx Deployment logs.";
    "clean" = "Remove all Kubernetes cert-manager resources for a deployment (Issuer, Cert, Secret, Ingress, Order, Challenge).";
    "uninstall" = "Uninstall Certificate Manager (Helm chart).";
}

SubMenu $PSScriptRoot $command $subCommand $subCommands