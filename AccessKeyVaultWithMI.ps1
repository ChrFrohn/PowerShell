Connect-AzAccount -Identity 
 
$KeyVaultName = "" # The name of your key vault
$KeyVaultSecretName = "" # The name of the secret in the above key vualt
 
$Key = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretName
$Key.SecretValueText # Prints the secret value in clear text
