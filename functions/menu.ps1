function Logo()
{
    Write-Host ''
    Write-Host '      __       __   ___   _______  '
    Write-Host '     /  \     |  | /  /  |  _____| '
    Write-Host '    /    \    |  |/  /   |  |____  '
    Write-Host '   /  /\  \   |     |    |____   | '
    Write-Host '  /  ____  \  |  |\  \    ____|  | '
    Write-Host ' /__/    \__\ |__| \__\  |_______| '
    Write-Host ''
}

function Welcome()
{
    Write-Host 'Welcome to the AKS (Azure Kubernetes Service) CLI (aks)!'
    Write-Host ''
    Write-Host 'Also available: Azure CLI (az), Kubernetes CLI (kubectl), Helm v2 & v3 CLI (helm & helm3), Wercher/Stern (stern)'
    Write-Host 'Also: Azure DevOps CLI extension (az devops), Curl, Git, Nano, PS-Menu'
}

function ShowCommandBreadcrumbs($commandPrefix)
{
    Write-Host "$commandPrefix <command>"
}

function ShowCommands($commands)
{
    Write-Host ''
    $maxSubCommandLength = ($commands.Keys | Measure-Object -Maximum -Property Length).Maximum
    ForEach ($key in ($commands.Keys | Sort-Object)) {
        Write-Host ("    $($key.PadRight($maxSubCommandLength + 4)): $($commands["$key"])")
    }
    Write-Host ''
}

function ShowMenu($commandPrefix, $commands)
{
    Logo
    if ($commandPrefix -eq "aks")
    {
        Welcome
    }
    else
    {
        ShowCommandBreadcrumbs $commandPrefix
    }
    Write-Host ''
    Write-Host 'Here are the commands:'
    ShowCommands $commands
    Write-Host ("e.g. try '$commandPrefix $($commands.keys[0] | Select-Object -first 1)'")
    Write-Host ''
}

function ShowSubMenu($commands)
{
    ShowMenu "aks $arg0" $commands
}

function ValidateCommand($commandPrefix, $command, $commands, $noScriptFile = $false)
{
    if ($command) 
    {
        if ($commands.Contains($command)) 
        {
            if($noScriptfile)
            {
                return
            }

            $commandPrefixPath = $commandPrefix.Replace(' ', '/')
            $path = "$PSScriptRoot/$commandPrefixPath/$command.ps1"
            $scriptExists = [System.IO.File]::Exists($path)
            if ($scriptExists) 
            {
                return $path
            }
            else
            {
                Write-Error "Script for command does not exist: $path"
            }
        }
        else
        {
            Write-Error "Invalid command '$command'"
        }
    }

    ShowMenu $commandPrefix $commands
    exit
}

function ValidateNoScriptSubCommand($commands)
{
    ValidateCommand "aks $arg0" $arg1 $commands $true
}

function MainMenu($commands)
{
    $path = ValidateCommand "aks" $arg0 $commands

    & $path $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 $arg10 $arg11
}

function SubMenu($commands)
{
    $path = ValidateCommand "aks $arg0" $arg1 $commands

    & $path $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 $arg10 $arg11
}

function SubSubMenu($commands)
{
    $path = ValidateCommand "aks $arg0 $arg1" $arg2 $commands

    & $path $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 $arg10 $arg11
}