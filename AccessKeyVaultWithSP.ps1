$ApplicationId = "" # AppID for the Service Princiapl that has Key Vault Secrets User role 
$CertificateThumbprint = "" # 
$TenantID = "" # The tenant ID for the Service Princiapl that has Key Vault Secrets User role 

Connect-AzAccount -ApplicationId $ApplicationId -CertificateThumbprint $CertificateThumbprint -Tenant $TenantID 

$KeyVaultName = "" # The name of your key vault
$KeyVaultSecretName = "" # The name of the secret in the above key vualt

$Key = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretName
$Key.SecretValueText # Prints the secret value in clear text
