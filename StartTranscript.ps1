$Date = Get-Date -Format "dd-MM-yyyy"
$LogFileName = ""
Start-Transcript -Path ".\$LogFileName$Date.txt" -Verbose

## Code

Stop-Transcript -Verbose
