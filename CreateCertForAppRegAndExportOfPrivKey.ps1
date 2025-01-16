$CN = "MyAppReg" #Name of your cert.
$cert=New-SelfSignedCertificate -Subject "CN=$CN" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -NotAfter (Get-Date).AddYears(5)

#Thumbprint value
$Thumbprint = $Cert.Thumbprint

#Export cert. to users download folder
Get-ChildItem Cert:\CurrentUser\my\$Thumbprint | Export-Certificate -FilePath $env:USERPROFILE\Downloads\AppRegCert.cer

# Export the private key to a PFX file
$Password = ConvertTo-SecureString -String "YourPasswordHere" -Force -AsPlainText
Export-PfxCertificate -Cert "Cert:\CurrentUser\my\$Thumbprint" -FilePath "$env:USERPROFILE\Downloads\AppRegCert.pfx" -Password $Password

Write-Output "$Thumbprint <- Copy/paste this (save it)"
