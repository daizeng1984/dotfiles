$TaskName = "AutoHotKey"
$TaskDescr = "AutoHotKey autostart"
$TaskCommand = "`"$(Convert-Path -Path '~/.dotfiles/windows/macv2.exe')`""
$TaskArg = ""
# $TaskCommand = "`"$(Convert-Path -Path '~/scoop/apps/autohotkey1.1/current/AutoHotkeyU64.exe')`""
# $TaskArg = "`"$(Convert-Path '~/.dotfiles/windows/mac.ahk')`""

# connect to the local machine.
$service = new-object -ComObject("Schedule.Service")
$service.Connect()
$rootFolder = $service.GetFolder("\")
$TaskDefinition = $service.NewTask(0)
$TaskDefinition.RegistrationInfo.Description = "$TaskDescr"
$TaskDefinition.Settings.Enabled = $true
$TaskDefinition.Settings.AllowDemandStart = $true
$TaskDefinition.Settings.StartWhenAvailable = $true
$TaskDefinition.Settings.StopIfGoingOnBatteries=$false
$TaskDefinition.Settings.DisallowStartIfOnBatteries=$false
$TaskDefinition.Settings.MultipleInstances=2
$TaskDefinition.Settings.RestartInterval="PT1M"
$TaskDefinition.Settings.RestartCount=999
$taskdefinition.Settings.WakeToRun=$false
$triggers = $TaskDefinition.Triggers
$trigger = $triggers.Create(9) # Log on
$trigger.Enabled = $true
$TaskDefinition.Principal.RunLevel =1
$TaskDefinition.Principal.UserId = "$env:UserName"
$Action = $TaskDefinition.Actions.Create(0)
$action.Path = "$TaskCommand"
$action.Arguments = "$TaskArg"
$rootFolder.RegisterTaskDefinition("$TaskName",$TaskDefinition,6,"$env:UserName",$null,3) | Out-Null
