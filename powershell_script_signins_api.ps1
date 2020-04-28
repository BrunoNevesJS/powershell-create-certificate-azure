$accessToken = Get-MSCloudIdMSGraphAccessTokenFromCert -TenantDomain "hypercloud.com.br" -ClientId a228981e-56f9-43f5-8e33-eb3cb2a61d42 -Certificate (dir Cert:\CurrentUser\My\71C5E26CF001313482750B39A5BC3FECDC5F990E)

$accessToken

$url = "https://graph.microsoft.com/beta/AuditLogs/signins"
$Headers = @{
'Authorization' = "bearer $accessToken"
}

$outputFile = "C:\Reporting\Report.csv"
 
$Users = Invoke-MSCloudIdMSGraphQuery -AccessToken $accessToken -GraphQuery "/v1.0/AuditLogs/signins"

#$Users


#Convert the stream result to an array
$resultarray = ConvertFrom-Csv -InputObject $Users
#Export result to CSV
$resultarray | Export-Csv "C:\SiteUsage.csv" -NoTypeInformation



#Invoke-WebRequest
#Invoke-MSCloudIdMSGraphQuery