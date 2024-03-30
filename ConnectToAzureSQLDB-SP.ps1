Import-Module SQLServer -Verbose

$ClientID = "" # enter application id that corresponds to the Service Principal" # Do not confuse with its display name
$TenantID = "" # enter the tenant ID of the Service Principal
$ClientSecret = "" #enter the secret associated with the Service Principal

$RequestToken = Invoke-RestMethod -Method POST `
           -Uri "https://login.microsoftonline.com/$TenantID/oauth2/token"`
           -Body @{ resource="https://database.windows.net/"; grant_type="client_credentials"; client_id=$ClientID; client_secret=$ClientSecret }`
           -ContentType "application/x-www-form-urlencoded"
$AccessToken = $RequestToken.access_token

#SQL server, database & table information 
$SQLServer = "ServerName.database.windows.net"
$DBName = "DatbaseName"
$DBTableName1 = "dbo.TableName"

#Database query
$Query = "Select * from $DBTableName1"
Invoke-Sqlcmd -ServerInstance $SQLServer -Database $DBName -AccessToken $AccessToken -Query $Query
