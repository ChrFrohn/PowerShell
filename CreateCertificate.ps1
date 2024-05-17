$CN = "MyAppReg" #Name of your cert.
$cert=New-SelfSignedCertificate -Subject "CN=$CN" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -NotAfter (Get-Date).AddYears(5)

#Thumbprint - Make note of this
$Thumbprint = $Cert.Thumbprint

#Export cert. to download folder - FilePath can be changed to your linking
Get-ChildItem Cert:\CurrentUser\my\$Thumbprint | Export-Certificate -FilePath $env:USERPROFILE\Downloads\AppRegCert.cer

Write-Output "$Thumbprint <- Copy/paste this (save it)" 
