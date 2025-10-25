# Arthur Alec Bernacett | System Administrator | Written for on-site client on test environment | RUN ON ADWS | 
# GUI | NETSEC | TOOLKITS CUSTOMIZATION | ONE-CLICK ACCESS FUNCTIONS | ONE-CLICK DOCUMENTATION | ONE-CLICK INFORMATION |

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

 # Domain Admin Check/Credentials Check
$cred = [System.Management.Automation.PSCredential]::Empty
while ($cred -eq [System.Management.Automation.PSCredential]::Empty) {
    $cred = Get-Credential
}
$adUserName = $cred.UserName

if ($adUserName -match '\\') {
    $username = $adUserName.Split('\')[1]
} elseif ($adUserName -match '@') {
    $username = $adUserName.Split('@')[0]
} else {
    $username = $adUserName
}
Import-Module ActiveDirectory
$isDomainAdmin = (Get-ADUser $username -Properties MemberOf).MemberOf -match 'CN=(Domain Admins|Administrators)'
if ($isDomainAdmin) {
    [System.Windows.Forms.MessageBox]::Show("Welcome $adUserName`n Systems Admin Utility V.013", "Access Granted", 'OK', 'Information')
} else {
    [System.Windows.Forms.MessageBox]::Show("Access Denied, All attempts are logged and sent to the sysadmin email.", "Access Denied", 'OK', 'Error')
    Start-Sleep -Seconds 1
    exit
}
# Define Tools & Shares
$ToolsFunction = @{
    "Event Viewer"     = "eventvwr.msc"
    "Services"         = "services.msc"
    "Network Config"   = "ncpa.cpl"
    "Registry Edit"    = "regedit.exe"
    "Powershell ISE"   = "powershell_ise.exe"
    "Remote Desktop"   = "mstsc.exe"
    "AD Users & Comp"  = "dsa.msc"
    "God Mode"         = "$env:USERPROFILE\Desktop\GodMode"
    "NMAP"             = "C:\Program Files (x86)\Nmap\zenmap"
    "ANGRY IP Scanner" = "C:\Program Files\Angry IP Scanner\ipscan.exe"
    ""                 = ""
    "WireShark"        = "C:\Program Files\Wireshark\Wireshark.exe"
}
$shares = @{
    "Drive0"            = ''
    "Drive01"           = ''
    "Drive02"           = ''
    "Drive03"           = ''
    "Drive04"           = ''
    "Drive05"           = ''
    "Drive06"           = ''
    "Drive07"           = ''
}
$rdp = @{
    "RDP_SHORTCUT0"          = ''
    "RDP_SHORTCUT01"         = ''
    "RDP_SHORTCUT02"         = ''
    "RDP_SHORTCUT10"         = ''
    "RDP_SHORTCUT03"         = ''
    "RDP_SHORTCUT04"         = ''
    "RDP_SHORTCUT05"         = ''
    "RDP_SHORTCUT06"         = ''
    "RDP_SHORTCUT07"         = ''
    "RDP_SHORTCUT08"         = ''
    "RDP_SHORTCUT09"         = ''
}
$printers = @{
    "PRINTER0"        = ''
    "PRINTER01"       = ''
    "PRINTER02"       = ''
    "PRINTER03"       = ''
    "PRINTER04"       = ''
    "PRINTER05"       = ''
    "PRINTER06"       = ''
    "PRINTER07"       = ''
    "PRINTER08"       = ''
    "PRINTER09"       = ''
    "PRINTER10"       = ''
    "PRINTER11"       = ''
    "PRINTER12"       = ''
    "PRINTER13"       = ''
    "PRINTER14"       = ''
}
$Documentation = @{
    "DOCUMENT0"         =  ""
    "DOCUMENT01"        =  ""
    "DOCUMENT02"        =  ""
    "DOCUMENT03"        =  ""
    "DOCUMENT04"        =  ""
    "DOCUMENT05"        =  ""
    "DOCUMENT06"        =  ""
    "DOCUMENT07"        =  ""
}
$VendorSupport = @{
    "Vendor_Info_1"          =  ""
    "Vendor_Info_2"          =  ""
    "Vendor_Info_3"          =  ""
    "Vendor_Info_4"          =  ""
    "Vendor_Info_5"          =  ""
    "Vendor_Info_6"          =  ""
    "Vendor_Info_7"          =  ""
    "Vendor_Info_8"          =  ""
}
$VIP = @{
    "ADMIN0"           =  ""
    "ADMIN1"           =  ''
    "ADMIN2"           =  ''
    "ADMIN3"           =  ''
    "ADMIN4"           =  ''
    "ADMIN5"           =  ''
    "ADMIN6"           =  ''
}
# GUI/Interface
$form = New-Object System.Windows.Forms.Form
$form.Text = "Systems Admin Utility V.22"
$form.Size = New-Object System.Drawing.Size(650,245)
$form.StartPosition = "CenterScreen"
$form.MaximizeBox = $false
$form.FormBorderStyle = 'FixedDialog'
$form.TopLevel = $true
$iconPath = ""
$form.Icon = New-Object System.Drawing.Icon($iconPath)
#Custom Background option
#$imagePath = "c:\path\image.png"
#$image = [System.Drawing.Image]::FromFile($imagePath)
#$form.BackgroundImage = $image
#$form.BackgroundImageLayout = 'Stretch'  # Options: None, Tile, Center, Stretch, Zoom

# Headings/Labels
$label = New-Object System.Windows.Forms.Label
$label.Text = "Tools Selection"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20,30)
$form.Controls.Add($label)

$label2 = New-Object System.Windows.Forms.Label
$label2.Text = "Shared Drives"
$label2.AutoSize = $true
$label2.Location = New-Object System.Drawing.Point(177,30)
$form.Controls.Add($label2)

$label3 = New-Object System.Windows.Forms.Label
$label3.Text = "Printers"
$label3.AutoSize = $true
$label3.Location = New-Object System.Drawing.Point(334,30)
$form.Controls.Add($label3)

$label4 = New-Object System.Windows.Forms.Label
$label4.Text = "Useful links"
$label4.AutoSize = $true
$label4.Location = New-Object System.Drawing.Point(334,100)
$form.Controls.Add($label4)

$label5 = New-Object System.Windows.Forms.Label
$label5.Text = "Current User:$adUserName`nHost Name: $hostname $env:COMPUTERNAME"
$label5.AutoSize = $true
$label5.Location = New-Object System.Drawing.Point(175,180)
$form.Controls.Add($label5)

$label6 = New-Object System.Windows.Forms.Label
$label6.Text = "Vendor Support"
$label6.AutoSize = $true
$label6.Location = New-Object System.Drawing.Point(20,100)
$form.Controls.Add($label6)

$label7 = New-Object System.Windows.Forms.Label
$label7.Text = "Contact List"
$label7.AutoSize = $true
$label7.Location = New-Object System.Drawing.Point(177,100)
$form.Controls.Add($label7)

$label8 = New-Object System.Windows.Forms.Label
$label8.Text = "   Developer: A. Bernacett`n"
$label8.AutoSize = $true
$label8.Location = New-Object System.Drawing.Point(490,180)
$form.Controls.Add($label8)

$label9 = New-Object System.Windows.Forms.Label
$label9.Text = "Remote Servers"
$label9.AutoSize = $true
$label9.Location = New-Object System.Drawing.Point(494,30)
$form.Controls.Add($label9)

# Tool drop down list
$comboBox1 = New-Object System.Windows.Forms.ComboBox
$comboBox1.Location = New-Object System.Drawing.Point(20,50)
$comboBox1.Size = New-Object System.Drawing.Size(125,20)
$comboBox1.DropDownStyle = 'DropDownList'
$comboBox1.Items.AddRange($ToolsFunction.Keys)
$form.Controls.Add($comboBox1)
$comboBox1.BackColor = [System.Drawing.Color]::PaleTurquoise

# Shared Drives drop down list
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(180,50)
$comboBox.Size = New-Object System.Drawing.Size(125,20)
$comboBox.DropDownStyle = 'DropDownList'
$comboBox.Items.AddRange($shares.Keys)
$form.Controls.Add($comboBox)
$comboBox.BackColor = [System.Drawing.Color]::PaleTurquoise

# Printers drop down list
$comboBox2 = New-Object System.Windows.Forms.ComboBox
$comboBox2.Location = New-Object System.Drawing.Point(340,50)
$comboBox2.Size = New-Object System.Drawing.Size(125,20)
$comboBox2.DropDownStyle = 'DropDownList'
$comboBox2.Items.AddRange($printers.Keys)
$form.Controls.Add($comboBox2)
$comboBox2.BackColor = [System.Drawing.Color]::PaleTurquoise

# Documentation drop down list
$comboBox3 = New-Object System.Windows.Forms.ComboBox
$comboBox3.Location = New-Object System.Drawing.Point(340,120)
$comboBox3.Size = New-Object System.Drawing.Size(125,20)
$comboBox3.DropDownStyle = 'DropDownList'
$comboBox3.Items.AddRange($Documentation.Keys)
$form.Controls.Add($comboBox3)
$comboBox3.BackColor = [System.Drawing.Color]::PaleTurquoise

# Vendor Support drop down list
$comboBox4 = New-Object System.Windows.Forms.ComboBox
$comboBox4.Location = New-Object System.Drawing.Point(20,120)
$comboBox4.Size = New-Object System.Drawing.Size(125,20)
$comboBox4.DropDownStyle = 'DropDownList'
$comboBox4.Items.AddRange($VendorSupport.Keys)
$form.Controls.Add($comboBox4)
$comboBox4.BackColor = [System.Drawing.Color]::PaleTurquoise

# VIP Contact drop down list
$comboBox5 = New-Object System.Windows.Forms.ComboBox
$comboBox5.Location = New-Object System.Drawing.Point(180,120)
$comboBox5.Size = New-Object System.Drawing.Size(125,20)
$comboBox5.DropDownStyle = 'DropDownList'
$comboBox5.Items.AddRange($VIP.Keys)
$form.Controls.Add($comboBox5)
$comboBox5.BackColor = [System.Drawing.Color]::PaleTurquoise

# Remote Server drop down list
$comboBox6 = New-Object System.Windows.Forms.ComboBox
$comboBox6.Location = New-Object System.Drawing.Point(500,50)
$comboBox6.Size = New-Object System.Drawing.Size(125,20)
$comboBox6.DropDownStyle = 'DropDownList'
$comboBox6.Items.AddRange($RDP.Keys)
$form.Controls.Add($comboBox6)
$comboBox6.BackColor = [System.Drawing.Color]::PaleTurquoise


# Added: Historic Data Logging
$logFolder = "C:\AuditLogs"
$logPath = "$logFolder\\HistoricData.log"

if (-not (Test-Path $logFolder)) {
    New-Item -Path $logFolder -ItemType Directory | Out-Null
}
function Write-HistoricData {
    param (
        [string]$Action
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $logEntry = "[$timestamp] User: $user | Action: $Action"
    Add-Content -Path $logPath -Value $logEntry
}

# Example login audit
Write-HistoricData -Action "Logged in and launched script"

$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK"
$okButton.Size = New-Object System.Drawing.Size(70, 20)
$okButton.Location = New-Object System.Drawing.Point(17, 180)  # adjust as needed
$form.Controls.Add($okButton)
$okButton.Add_Click({
    $selectedShares         = $comboBox.SelectedItem
    $selectedTool           = $comboBox1.SelectedItem
    $selectedPrinters       = $comboBox2.SelectedItem
    $selectedInfrastructure = $comboBox3.SelectedItem
    $selectedVendorSupport  = $comboBox4.SelectedItem
    $selectedVIP            = $comboBox5.SelectedItem
    $selectedRDP            = $comboBox6.SelectedItem


    if ($selectedShares) {
        $sharesPath = $shares[$selectedShares]
        Write-Host "Opening shared folder: $sharesPath"
        Start-Process -FilePath $SharesPath
    }
    if ($selectedRDP) {
    $RDPPath = $rdp[$selectedRDP]
    Write-Host "Opening $selectedRDP"
    Start-Process $RDPPath
    }
    if ($selectedInfrastructure) {
    $infraPath = $Documentation[$selectedInfrastructure]
    Write-Host "Opening $selectedInfrastructure"
    Start-Process $infraPath
    }
    if ($selectedVendorSupport) {
    $VendorPath = $VendorSupport[$selectedVendorSupport]
    Write-Host "Opening $selectedVendorSupport"
    Start-Process $VendorPath
    }
    if ($selectedInfrastructure) {
    $infraPath = $Documentation[$selectedInfrastructure]
    Write-Host "Opening $selectedInfrastructure"
    Start-Process $infraPath
    }
    if ($selectedPrinters) {
    $PrintersPath = $Printers[$selectedPrinters]
    $command = $Printers[$selectedPrinters]
    Write-Host "Opening $selectedPrinters"
 
switch ($selectedPrinters) {
    "PRINTER0" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER1" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER2" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER3" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER4" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER5" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER6" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER7" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER8" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility",  
            "Printer Info", 'OK', 'Information'
        )      
    } 
    "PRINTER9" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
        "PRINTER10" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
            "PRINTER13" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
                "PRINTER14" {
        Start-Process $PrintersPath
        [System.Windows.Forms.MessageBox]::Show(
            "Model: __________`nIP: INSERTIP `nVendor: _____`nLocation: Location in facility", 
            "Printer Info", 'OK', 'Information'
        )      
    } 
} 
    }
    if ($selectedVIP) {
    $command = $VIP[$selectedVIP]
    Write-Host "Opening $selectedVIP contact information"

switch ($selectedVIP) {
    "ADMIN0" { 
        [System.Windows.Forms.MessageBox]::Show(
            "POSITION/ROLE`nCell Phone: (XXX)-XXX-XXXX`nEmail: ADMIN@EMAIL.COM`nLocation: LOCATION", 
            "Contact Information", 'OK', 'Information'
        )      
    }  
   "ADMIN1" { 
        [System.Windows.Forms.MessageBox]::Show(
            "POSITION/ROLE`nCell Phone: (XXX)-XXX-XXXX`nEmail: ADMIN@EMAIL.COM`nLocation: LOCATION", 
            "Contact Information", 'OK', 'Information'
        )               
    }
    "ADMIN2" { 
        [System.Windows.Forms.MessageBox]::Show(
            "POSITION/ROLE`nCell Phone: (XXX)-XXX-XXXX`nEmail: ADMIN@EMAIL.COM`nLocation: LOCATION", 
            "Contact Information", 'OK', 'Information'
        )               
    }
    "ADMIN3" { 
        [System.Windows.Forms.MessageBox]::Show(
            "POSITION/ROLE`nCell Phone: (XXX)-XXX-XXXX`nEmail: ADMIN@EMAIL.COM`nLocation: LOCATION", 
            "Contact Information", 'OK', 'Information'
        )               
    }
    "ADMIN4" { 
        [System.Windows.Forms.MessageBox]::Show(
            "POSITION/ROLE`nCell Phone: (XXX)-XXX-XXXX`nEmail: ADMIN@EMAIL.COM`nLocation: LOCATION", 
            "Contact Information", 'OK', 'Information'
        )               
    }
    "ADMIN5" { 
        [System.Windows.Forms.MessageBox]::Show(
            "POSITION/ROLE`nCell Phone: (XXX)-XXX-XXXX`nEmail: ADMIN@EMAIL.COM`nLocation: LOCATION", 
            "Contact Information", 'OK', 'Information'
        )               
    }
    "ADMIN6" { 
        [System.Windows.Forms.MessageBox]::Show(
            "POSITION/ROLE`nCell Phone: (XXX)-XXX-XXXX`nEmail: ADMIN@EMAIL.COM`nLocation: LOCATION", 
            "Contact Information", 'OK', 'Information'
        )               
    }
}
    }
    if ($selectedTool) {
        $command = $ToolsFunction[$selectedTool]
        Write-Host "Opening $selectedTool"

        switch ($selectedTool) {
            "God Mode" {
                if (-not (Test-Path $command)) {
                    New-Item -Path $command -ItemType Directory | Out-Null
                    Rename-Item -Path $command -NewName "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
                }
                Start-Process explorer.exe -ArgumentList ""$command""
                break
            }
            "NMAP" {
                Start-Process "C:\Program Files (x86)\Nmap\Zenmap.lnk"
            }
            "ANGRY IP Scanner" {
                Start-Process "C:\Program Files\Angry IP Scanner\ipscan.exe"
                break
            }
            "WireShark" {
                Start-Process "C:\Program Files\Wireshark\Wireshark.exe"
                break
            }
            default {
                Start-Process $command
            }
        }
    }

    $comboBox.SelectedIndex = -1
    $comboBox1.SelectedIndex = -1
    $comboBox2.SelectedIndex = -1
    $comboBox3.SelectedIndex = -1
    $comboBox4.SelectedIndex = -1
    $comboBox5.SelectedIndex = -1
})
$form.Controls.Add($okButton)

$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Text = "Exit"
$exitButton.Size = New-Object System.Drawing.Size(70, 20)
$exitButton.Location = New-Object System.Drawing.Point(95,180)
$exitButton.Add_Click({
    $form.Close()
})
$form.Controls.Add($exitButton)

$form.ShowDialog() | Out-Null
