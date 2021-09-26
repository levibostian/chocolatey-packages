

$ErrorActionPreference = 'Stop'
$checksum = 'B767F421917DE075A38381F6495E5BBB5BA058B25D1FA3145FFA714919743F71'
$url = 'https://github.com/FreeTubeApp/FreeTube/releases/download/v0.14.0-beta/freetube-0.14.0-setup-x64.exe'

# How I got the below information:
# Open webpage where you download the windows battle.net launcher. 
# Open network developer console and wait for the download to start to your 
# computer. You will see a URL with a 200 response where the response is a bunch
# of text meaning it's probably a binary file download. 
$packageArgs = @{
  packageName   = 'freetube'
  fileType      = 'exe'
  url           = $url 
  validExitCodes= @(0)
  softwareName  = 'freetube*' # name of the downloaded .exe
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs