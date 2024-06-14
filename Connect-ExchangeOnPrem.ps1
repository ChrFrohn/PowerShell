# Exchange on-premise Authentification
$Username = "" # Exchange Admin username 
$Password = "" # Exchange Admin Password
$ExchangeConnecionURI = "" # Sample "http://Exchangeservername.Domainname.com/PowerShell/"

$Password = ConvertTo-SecureString $Password -AsPlainText -Force
$UserCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $Password
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $ExchangeConnecionURI -Authentication Kerberos -Credential $UserCredential
Import-PSSession $Session

Get-Mailbox 
