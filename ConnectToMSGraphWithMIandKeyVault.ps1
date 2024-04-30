# Connect to Azure using af Managed Identity (VM)
Connect-AzAccount -Identity 
 
$KeyVaultName = "" # The name of your Azure Key Vault
$KeyVaultSecretName = "" # The name of the Secret entry in the Azure Key Vault
$KeyVaultTenantIDName = "" # The name of the TenantID entry in the Azure Key Vault
$KeyVaultClientIDName = "" # The name of the ClientID entry in the Azure Key Vault

# Fetch the values from the Azure Key vault
$KeyVaultSecret = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretName -AsPlainText
$KeyVaultTenantID = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultTenantIDName -AsPlainText
$KeyVaultClientID = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultClientIDName -AsPlainText

# Connect to the Microsoft Graph with the Service Principal usinge the values from the Azure Key vault
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
$AllUsers = Invoke-RestMethod -Uri $url -Headers $headers -Method Get -ErrorAction Stop  
$AllUsers.value
