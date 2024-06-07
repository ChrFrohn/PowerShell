# Permissions - Requried:
# Application.Read.All

# Service Prinicipal auth to Microsoft Graph
$ClientID = ""
$ClientSecret = ""
$TenantID = ""

# The permission ID you are looking for - Use this to look up the ID you want to find https://learn.microsoft.com/en-us/graph/permissions-reference
$GraphPermissionID = "b633e1c5-b582-4048-a93e-9f11b44c7e96" 

# URI to get all Service Principals
$URIToGetAllSPs = "https://graph.microsoft.com/v1.0/servicePrincipals/"

# Microsoft Graph authentication
$body =  @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    Client_Id     = $ClientID
    Client_Secret = $ClientSecret
}
 
$connection = Invoke-RestMethod `
    -Uri https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token `
    -Method POST `
    -Body $body

$headers = @{
        "Authorization" = "Bearer " + $connection.access_token
    }

# Get all Service Principals in the tenant
$GetAllSP = @()
$response = Invoke-RestMethod -Uri $URIToGetAllSPs -Headers $headers -Method Get
$GetAllSP += $response.value

while ($response.'@odata.nextLink') 
{
    $response = Invoke-RestMethod -Uri $response.'@odata.nextLink' -Headers $headers -Method Get
    $GetAllSP += $response.value
}

# Go through each Service Principal and check if the permission is assigned
Foreach($SP in $GetAllSP)
{
    $SPID = $SP.Id
    $URIToSPAppRoles = "https://graph.microsoft.com/v1.0/servicePrincipals/$SPID/appRoleAssignments"
    $GetSPAppRoles = Invoke-RestMethod -Uri $URIToSPAppRoles -Headers $headers -Method Get

    If($GetSPAppRoles.value -match $GraphPermissionID)
    {
        # Output of the Service Principal Display Name and App ID
        $SP.displayName + " /// " + $SP.id
    }
}
