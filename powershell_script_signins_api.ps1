$accessToken = Get-MSCloudIdMSGraphAccessTokenFromCert -TenantDomain "hypercloud.com.br" -ClientId a228981e-56f9-43f5-8e33-eb3cb2a61d42 -Certificate (dir Cert:\CurrentUser\My\71C5E26CF001313482750B39A5BC3FECDC5F990E)

$accessToken

$url = "https://graph.microsoft.com/beta/AuditLogs/signins"
$Headers = @{
'Authorization' = "bearer $accessToken"
}
$outputFile = "C:\Reporting\Report.csv"
$myReport = (Invoke-WebRequest -UseBasicParsing -Headers $Headers -Uri $url)
$convertedReport = ($myReport.Content | ConvertFrom-Json)
$convertedReport | ConvertTo-Csv -NoTypeInformation | Add-Content $outputFile