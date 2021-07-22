#Import VMware CLI modul
Import-module -Name VMware.PowerCLI

#Login for vCenter
$User = ""
$Password = ""
$vCenterIP = ""

#Backup Location
$BackupLocation = ""

#Creates a folder to put the backup files with name of todays date.
New-Item -ItemType Directory -Path $BackupLocation\$((Get-Date).ToShortDateString())

#Connect to vCenter
Connect-viserver $vCenterIP -User $User -Password $Password
Set-PowerCLIConfiguration -InvalidCertificateAction ignore -Confirm:$false

#Get VMware hots
$VMhosts = Get-VMHost
foreach ($VMhost in $VMhosts) {
     Get-VMHostFirmware -VMHost $VMhost -BackupConfiguration -DestinationPath "$BackupLocation\$((Get-Date).ToShortDateString())"
}

#Disconnect from vCenter
Disconnect-viserver -Confirm:$false

#Clean Up backup files
$Backups = Get-ChildItem $BackupLocation
$Date = (Get-Date).AddDays(-14).ToShortDateString()

Foreach ($Backup in $Backups)
{
    if ($Backup.Name -lt $Date)
    {
        Remove-Item $Backup.Name -Force -Verbose
    }
}
