$accessToken = Get-MSCloudIdMSGraphAccessTokenFromCert -TenantDomain "hypercloud.com.br" -ClientId a228981e-56f9-43f5-8e33-eb3cb2a61d42 -Certificate (dir Cert:\CurrentUser\My\DA373879FF0D994688157FD4B9ABCCD4340CF71C)

$accessToken

$url = "https://graph.microsoft.com/beta/AuditLogs/signins"
$Headers = @{
'Authorization' = "bearer $accessToken"
}
$outputFile = "C:\Reporting\Report.csv"
$myReport = (Invoke-WebRequest -UseBasicParsing -Headers $Headers -Uri $url)
$convertedReport = ($myReport.Content | ConvertFrom-Json).value
$convertedReport | ConvertTo-Csv -NoTypeInformation | Add-Content $outputFile