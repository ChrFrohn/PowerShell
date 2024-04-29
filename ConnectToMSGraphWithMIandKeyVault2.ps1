Connect-AzAccount -Identity 

$KeyVaultName = "NameOfKeyVault"
$KeyVaultSecretName = "SecretName"
$KeyVaultTenantIDName = "TenantIDName"
$KeyVaultClientIDName = "ClientIDName"

$KeyVaultSecret = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretName -AsPlainText
$KeyVaultTenantID = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultTenantIDName -AsPlainText
$KeyVaultClientID = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultClientIDName -AsPlainText


$Body = @{   
   Grant_Type    = "client_credentials"   
   Scope         = "https://graph.microsoft.com/.default"   
   Client_Id     = $KeyVaultClientID
   Client_Secret = $KeyVaultSecret   
}  

$graphToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$KeyVaultTenantID/oauth2/v2.0/token" -Method POST -Body $Body | Select-Object -ExpandProperty Access_Token 
Connect-MgGraph -AccessToken $Body 
