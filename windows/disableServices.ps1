# Adapted from: https://github.com/LeDragoX/Win-Debloat-Tools/blob/main/src/scripts/Optimize-ServicesRunning.ps1
# run in powershell: 
# sudo.ps1 $env:HOMEPATH/.dotfiles/windows/disableServices.ps1

function Write-Style() {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [System.Object] $Object = '',

        [Parameter(Position = 1)]

        [ValidateSet('Blink', 'Bold', 'Italic', 'Regular', 'Strikethrough', 'Underline')]
        [String]        $Style = 'Regular',

        [Alias('Color')]
        [Parameter(Position = 2)]
        [ValidateSet('Black', 'Blue', 'DarkBlue', 'DarkCyan', 'DarkGray', 'DarkGreen', 'DarkMagenta', 'DarkRed', 'DarkYellow', 'Cyan', 'Gray', 'Green', 'Red', 'Magenta', 'White', 'Yellow')]
        [String]        $ForeColor = 'White',
        [Parameter(Position = 3)]
        [ValidateSet('Black', 'Blue', 'DarkBlue', 'DarkCyan', 'DarkGray', 'DarkGreen', 'DarkMagenta', 'DarkRed', 'DarkYellow', 'Cyan', 'Gray', 'Green', 'Red', 'Magenta', 'White', 'Yellow')]
        [String]        $BackColor = 'None',
        [Parameter(Position = 4)]
        [Switch]        $NoNewline
    )

    $BackColors = @{
        "Black"       = "$([char]0x1b)[40m"
        "DarkBlue"    = "$([char]0x1b)[44m"
        "DarkGreen"   = "$([char]0x1b)[42m"
        "DarkCyan"    = "$([char]0x1b)[46m"
        "DarkGray"    = "$([char]0x1b)[100m"
        "DarkRed"     = "$([char]0x1b)[41m"
        "DarkMagenta" = "$([char]0x1b)[45m" # Doesn't work on PowerShell, but works on the Terminal
        "DarkYellow"  = "$([char]0x1b)[43m"
        "Gray"        = "$([char]0x1b)[47m"
        "Blue"        = "$([char]0x1b)[104m"
        "Green"       = "$([char]0x1b)[102m"
        "Cyan"        = "$([char]0x1b)[106m"
        "Red"         = "$([char]0x1b)[101m"
        "Magenta"     = "$([char]0x1b)[105m"
        "Yellow"      = "$([char]0x1b)[103m"
        "White"       = "$([char]0x1b)[107m"
    }

    $ForeColors = @{
        "Black"       = "$([char]0x1b)[30m"
        "DarkBlue"    = "$([char]0x1b)[34m"
        "DarkGreen"   = "$([char]0x1b)[32m"
        "DarkCyan"    = "$([char]0x1b)[36m"
        "DarkGray"    = "$([char]0x1b)[90m"
        "DarkRed"     = "$([char]0x1b)[31m"
        "DarkMagenta" = "$([char]0x1b)[35m" # Doesn't work on PowerShell, but works on the Terminal
        "DarkYellow"  = "$([char]0x1b)[33m"
        "Gray"        = "$([char]0x1b)[37m"
        "Blue"        = "$([char]0x1b)[94m"
        "Green"       = "$([char]0x1b)[92m"
        "Cyan"        = "$([char]0x1b)[96m"
        "Red"         = "$([char]0x1b)[91m"
        "Magenta"     = "$([char]0x1b)[95m"
        "Yellow"      = "$([char]0x1b)[93m"
        "White"       = "$([char]0x1b)[97m"
    }

    $Styles = @{
        "Blink"         = "$([char]0x1b)[5m"
        "Bold"          = "$([char]0x1b)[1m"
        "Italic"        = "$([char]0x1b)[3m"
        "Regular"       = "$([char]0x1b)[0m"
        "Strikethrough" = "$([char]0x1b)[9m"
        "Underline"     = "$([char]0x1b)[4m"
    }

    $FormattedText = "$($Styles.$Style)$($BackColors.$BackColor)$($ForeColors.$ForeColor)$Object"

    If ($NoNewline) {
        return Write-Host "$FormattedText" -NoNewline
    }

    Write-Host "$FormattedText"
    Write-Verbose "Reference ^^^ S: $Style, F: $ForeColor, B: $BackColor"
}


function Write-Status() {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory)]
        [String[]] $Types,
        [Parameter(Position = 1, Mandatory)]
        [String]   $Status,
        [Switch]   $Warning
    )


    $TypesDone = ""

    ForEach ($Type in $Types) {
        $TypesDone += "$([char]0x1b)[100m$([char]0x1b)[96m[$([char]0x1b)[97m$Type$([char]0x1b)[96m]$([char]0x1b)[m "
    }

    Write-Style "$TypesDone".Trim() -Style Bold -NoNewline

    If ($Warning) {

        Write-Style " $Status" -Color Yellow
    } Else {
        Write-Style " $Status" -Color Green
    }

}

function Set-ServiceStartup() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Automatic', 'Boot', 'Disabled', 'Manual', 'System')]
        [String]      $State,
        [Parameter(Mandatory = $true)]
        [String[]]    $Services,
        [String[]]    $Filter
    )

    Begin {
        $Script:SecurityFilterOnEnable = @("RemoteAccess", "RemoteRegistry")
        $Script:TweakType = "Service"
    }


    Process {
        ForEach ($Service in $Services) {
            If (!(Get-Service $Service -ErrorAction SilentlyContinue)) {
                Write-Status -Types "?", $TweakType -Status "The `"$Service`" service was not found." -Warning
                Continue
            }

            If (($Service -in $SecurityFilterOnEnable) -and (($State -eq 'Automatic') -or ($State -eq 'Manual'))) {
                Write-Status -Types "?", $TweakType -Status "Skipping $Service ($((Get-Service $Service).DisplayName)) to avoid a security vulnerability..." -Warning
                Continue
            }

            If ($Service -in $Filter) {
                Write-Status -Types "?", $TweakType -Status "The $Service ($((Get-Service $Service).DisplayName)) will be skipped as set on Filter..." -Warning
                Continue
            }

            Write-Status -Types "@", $TweakType -Status "Setting $Service ($((Get-Service $Service).DisplayName)) as '$State' on Startup..."
            Get-Service -Name "$Service" -ErrorAction SilentlyContinue | Set-Service -StartupType $State

        }
    }
}


function Disable-Bloated-Services() {

    # Services which will be totally disabled
    $ServicesToDisabled = @(
        "DiagTrack"                                 # DEFAULT: Automatic | Connected User Experiences and Telemetry
        "diagnosticshub.standardcollector.service"  # DEFAULT: Manual    | Microsoft (R) Diagnostics Hub Standard Collector Service
        #"dmwappushservice"                          # DEFAULT: Manual    | Device Management Wireless Application Protocol (WAP)
        #"fhsvc"                                     # DEFAULT: Manual    | File History Service
        "GraphicsPerfSvc"                           # DEFAULT: Manual    | Graphics performance monitor service
        "lfsvc"                                     # DEFAULT: Manual    | Geolocation Service
        "MapsBroker"                                # DEFAULT: Automatic | Downloaded Maps Manager
        "RemoteAccess"                              # DEFAULT: Disabled  | Routing and Remote Access
        "RemoteRegistry"                            # DEFAULT: Disabled  | Remote Registry
        "RetailDemo"                                # DEFAULT: Manual    | The Retail Demo Service controls device activity while the device is in retail demo mode.
        "TrkWks"                                    # DEFAULT: Automatic | Distributed Link Tracking Client
        "WSearch"                                   # DEFAULT: Automatic | Windows Search (100% Disk usage on HDDs)
    )

    # Making the services to run only when needed as 'Manual' | Remove the # to set to Manual
    $ServicesToManual = @(
        "BITS"                           # DEFAULT: Manual    | Background Intelligent Transfer Service
        "edgeupdate"                     # DEFAULT: Automatic | Microsoft Edge Update Service
        "edgeupdatem"                    # DEFAULT: Manual    | Microsoft Edge Update Service²
        # "FontCache"                      # DEFAULT: Automatic | Windows Font Cache
        "PhoneSvc"                       # DEFAULT: Manual    | Phone Service (Manages the telephony state on the device)
        "SCardSvr"                       # DEFAULT: Manual    | Smart Card Service
        "stisvc"                         # DEFAULT: Automatic | Windows Image Acquisition (WIA) Service
        #"WbioSrvc"                       # DEFAULT: Manual    | Windows Biometric Service (required for Fingerprint reader / Facial detection)
        "wisvc"                          # DEFAULT: Manual    | Windows Insider Program Service
        "WMPNetworkSvc"                  # DEFAULT: Manual    | Windows Media Player Network Sharing Service
        "WpnService"                     # DEFAULT: Automatic | Windows Push Notification Services (WNS)
        <# Bluetooth services #>
        # "BTAGService"                    # DEFAULT: Manual    | Bluetooth Audio Gateway Service
        # "BthAvctpSvc"                    # DEFAULT: Manual    | AVCTP Service
        # "bthserv"                        # DEFAULT: Manual    | Bluetooth Support Service
        # "RtkBtManServ"                   # DEFAULT: Automatic | Realtek Bluetooth Device Manager Service
        <# Diagnostic Services #>
        "DPS"                            # DEFAULT: Automatic | Diagnostic Policy Service
        "WdiServiceHost"                 # DEFAULT: Manual    | Diagnostic Service Host
        "WdiSystemHost"                  # DEFAULT: Manual    | Diagnostic System Host
        <# Network Services #>
        # "iphlpsvc"                       # DEFAULT: Automatic | IP Helper Service (IPv6 (6to4, ISATAP, Port Proxy and Teredo) and IP-HTTPS)
        # "lmhosts"                        # DEFAULT: Manual    | TCP/IP NetBIOS Helper
        #"NetTcpPortSharing"             # DEFAULT: Disabled  | Net.Tcp Port Sharing Service
        # "SharedAccess"                   # DEFAULT: Manual    | Internet Connection Sharing (ICS)
        <# Telemetry Services #>
        "Wecsvc"                         # DEFAULT: Manual    | Windows Event Collector Service
        "WerSvc"                         # DEFAULT: Manual    | Windows Error Reporting Service
        <# Xbox services #>
        "XblAuthManager"                 # DEFAULT: Manual    | Xbox Live Auth Manager
        "XblGameSave"                    # DEFAULT: Manual    | Xbox Live Game Save
        "XboxGipSvc"                     # DEFAULT: Manual    | Xbox Accessory Management Service
        "XboxNetApiSvc"                  # DEFAULT: Manual    | Xbox Live Networking Service
        <# Printer services #>
        #"PrintNotify"                   # DEFAULT: Manual    | WARNING! REMOVING WILL TURN PRINTING LESS MANAGEABLE | Printer Extensions and Notifications
        #"Spooler"                       # DEFAULT: Automatic | WARNING! REMOVING WILL DISABLE PRINTING              | Print Spooler
        <# Wi-Fi services #>
        #"WlanSvc"                       # DEFAULT: Manual (No Wi-Fi devices) / Automatic (Wi-Fi devices) | WARNING! REMOVING WILL DISABLE WI-FI | WLAN AutoConfig
        <# 3rd Party Services #>

        "gupdate"                        # DEFAULT: Automatic | Google Update Service

        "gupdatem"                       # DEFAULT: Manual    | Google Update Service²
    )

    $ServicesToAutomatic = @(
        "ndu"                            # DEFAULT: Automatic | Windows Network Data Usage Monitoring Driver (Shows network usage per-process on Task Manager)
    )

    $Remove = $false
    If ($Revert) {
        Write-Status -Types "*", "Service" -Status "Reverting the tweaks is set to '$Revert'." -Warning
        Set-ServiceStartup -State 'Manual' -Services $ServicesToDisabled
    } Else {
        Set-ServiceStartup -State 'Disabled' -Services $ServicesToDisabled
    }

    Set-ServiceStartup -State 'Manual' -Services $ServicesToManual
    Set-ServiceStartup -State 'Automatic' -Services $ServicesToAutomatic
}

# List all services:
#Get-Service | Select-Object StartType, Status, Name, DisplayName, ServiceType | Sort-Object StartType, Status, Name | Format-Table

Disable-Bloated-Services
