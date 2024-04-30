# This code is realted to following blog post:
# 
Connect-AzAccount -Identity 

$KeyVaultName = "NameOfKeyVault"
$KeyVaultSecretName = "SecretName"
$KeyVaultTenantIDName = "TenantIDName"
$KeyVaultClientIDName = "ClientIDName"

$KeyVaultSecret = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretName -AsPlainText
$KeyVaultTenantID = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultTenantIDName -AsPlainText
$KeyVaultClientID = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultClientIDName -AsPlainText
 
$body =  @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    Client_Id     = $KeyVaultClientID
    Client_Secret = $KeyVaultSecret
    }
 
$connection = Invoke-RestMethod `
    -Uri https://login.microsoftonline.com/$KeyVaultTenantID/oauth2/v2.0/token `
    -Method POST `
    -Body $body


$headers = @{
                "Authorization" = "Bearer " + $connection.access_token
            }

$url = "https://graph.microsoft.com/v1.0/users/"

#Output all users
Invoke-RestMethod -Uri $url -Headers $headers -Method Get -ErrorAction Stop  
