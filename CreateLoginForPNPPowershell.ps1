$password = ConvertTo-SecureString -String "YOURPASSWORD" -AsPlainText -Force
Register-PnPAzureADApp -ApplicationName "PnP-PowerShell" -Tenant TENANTNAME.onmicrosoft.com -Store CurrentUser -DeviceLogin

$thumbprint = "COPY THUMBPRINT OUTPUL FROM ABOVE"
Connect-PnPOnline -ClientId "client id for the app created above" -Url "https://TENANTNAME.sharepoint.com" -Tenant TENANTNAME.onmicrosoft.com -Thumbprint $thumbprint

#Test connecting with. get-pnpuser
