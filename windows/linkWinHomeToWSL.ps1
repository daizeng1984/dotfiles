function Create-And-Link-WSLHome-Folder {
    param(
        [string]$FolderName
    )

    $FolderPath = '\\wsl.localhost\Ubuntu\home\zengdai\' + "$FolderName"

    if (-not (Test-Path -Path $FolderPath)) {
        New-Item -ItemType Directory -Path $FolderPath
        Write-Host "Folder $FolderPath created."
    } else {
        Write-Host "Folder $FolderPath already exists."
    }

    New-Item -ItemType SymbolicLink -Path "~" -Name "$FolderName" -Value "$FolderPath"
}

Create-And-Link-WSLHome-Folder -FolderName "Downloads"
Create-And-Link-WSLHome-Folder -FolderName "Music"
Create-And-Link-WSLHome-Folder -FolderName "Pictures"
Create-And-Link-WSLHome-Folder -FolderName "Videos"
Create-And-Link-WSLHome-Folder -FolderName "Documents"
Create-And-Link-WSLHome-Folder -FolderName "Workspace"
