<#
.SYNOPSIS
    This PowerShell script fetches a specific SQL query file from a GitHub repository using the GitHub API.

.DESCRIPTION
    The script uses the GitHub API to fetch a specific SQL query file from a repository. It requires a GitHub username and personal access token for authentication. 
    The repository name and file path are also required. The script sends an API request and receives a response containing the file content in base64 format. It then decodes this content and outputs it. 
    This script is initially tailored for my needs. Modify to suit your needs.

.NOTES
    Filename: ImportSQLqueryFromGitHubIntoPowerShell.ps1
    Version: 1.0
    Author: ChrFrohn
    Blog: www.christianfrohn.dk
    LinkedIn: https://www.linkedin.com/in/frohn/
.LINK
    www.christianfrohn.dk/
#>

$Username = "" # Your GitHub username
$Token = "" # Your GitHub personal access token

$Repo = "" # The name of the Github repository
$File_path = "" # The path to the file in the repository

# GitHub API URL
$Url = "https://api.github.com/repos/$Username/$Repo/contents/$File_path"

# headers for the API request
$Headers = @{
    "Authorization" = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Token))))"
}

# Send the API request
$Response = Invoke-WebRequest -Uri $url -Headers $headers

# The API response contains the file content in base64, so we need to extract and decode it
$Content = $Response.Content | ConvertFrom-Json
$DecodedContent = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($content.content))

# The decoded content into a variable
$DecodedContent 

# The rest of your script goes here

# Example usage:
$SQLQuery = $DecodedContent
Invoke-Sqlcmd -ServerInstance "ServerName" -Database "DatabaseName" -Query $SQLQuery