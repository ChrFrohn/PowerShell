$Date = Get-Date -Format "dd-MM-yyyy"
$LogFileName = ""
Start-Transcript -Path ".\$LogFileName$Date.log" -Verbose

## Code

Stop-Transcript -Verbose
