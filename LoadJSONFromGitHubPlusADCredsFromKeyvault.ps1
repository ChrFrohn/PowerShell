# Auth information - Key vault
$KeyVaultName = "" 
$AzureSubscriptionID = ""

# Auth information - Key vault secrets
$Domain = "" # Your domain name
$KeyVaultSecretNameGitHub = "" # GitHub "personal" access token
$KeyVaultSecretNameSA_ADUserName = ""
$KeyVaultSecretNameSA_ADPassword = ""

# Connect to Azure - Managed ID
Connect-AzAccount -Identity -Subscription $AzureSubscriptionID | Out-Null

#### GITHUB ####

# Auth information - GitHub
$username = "" # Your GitHub username (or organization name)
$owner = $username
$repo = "" # The name of the repository
$file_path = "" # The path to the file in the repository

# GitHub authentication
$token = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretNameGitHub -AsPlainText # GitHub "personal" access token
$url = "https://api.github.com/repos/$owner/$repo/contents/$file_path" # GitHub API URL

# Header for the API request
$headers = @{ "Authorization" = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$token))))" }

# Send the API request to GitHub to get the file content
$response = Invoke-WebRequest -Uri $url -UseBasicParsing -Headers $headers
$content = $response.Content | ConvertFrom-Json
$GitHubFileContent = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($content.content))
$JSON = $GitHubFileContent | ConvertFrom-Json

#### Active Directory ####

# Authentification to AD
$ADUsername = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretNameSA_ADUserName -AsPlainText
$ADpassword = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretNameSA_ADPassword -AsPlainText
$Useradmin = "$Domain\$ADUsername"
$SecurePassword = ConvertTo-SecureString -String $ADpassword -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Useradmin , $SecurePassword

$JSON
$Credential
