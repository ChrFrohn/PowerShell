Import-Module SQLServer

$clientid = "" 
$tenantid = "" 
$secret = "" 

$request = Invoke-RestMethod -Method POST `
           -Uri "https://login.microsoftonline.com/$tenantid/oauth2/token"`
           -Body @{ resource="https://database.windows.net/"; grant_type="client_credentials"; client_id=$clientid; client_secret=$secret }`
           -ContentType "application/x-www-form-urlencoded"
$access_token = $request.access_token

Invoke-Sqlcmd -ServerInstance SERVERNAME.database.windows.net -Database DBNAME -AccessToken $access_token -query 'select * from dbo.NumberSerie where UsedBy IS NULL;'

