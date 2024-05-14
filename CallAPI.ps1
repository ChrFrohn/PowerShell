$baseURL = "https://hrsystem.com/"
$employeeEndpoint = "$baseURL/api/Employees"
$UserName = ""
$Password = ""

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))

$headers = @{
    Authorization = "Basic $base64AuthInfo"
    "Content-Type" = "application/json; charset=utf-8"
}
$response = Invoke-RestMethod -Uri $employeeEndpoint -Method Get -Headers $headers

$response
