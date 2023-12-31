param
(
  [Parameter(Mandatory=$true)]
  [string] $loadTestId,
  
  # Load Test data plane endpoint
  [Parameter(Mandatory=$true)]
  [string] $apiEndpoint,

  # optional - load test data plane api version
  [string] $apiVersion = "2023-04-01-preview",

  [string] $testRunId
)

. "$PSScriptRoot/common.ps1"

$urlRoot = "https://" + $apiEndpoint + "/test-runs/" + $testRunId + ":stop"

# Following is to get Invoke-RestMethod to work
$url = $urlRoot + "?api-version=" + $apiVersion

# Secure string to use access token with Invoke-RestMethod in Powershell
$accessTokenSecure = ConvertTo-SecureString -String $accessToken -AsPlainText -Force

Invoke-RestMethod `
  -Uri $url `
  -Method POST `
  -Authentication Bearer `
  -Token $accessTokenSecure `
  -Verbose:$verbose

Remove-Item $accessTokenFileName
