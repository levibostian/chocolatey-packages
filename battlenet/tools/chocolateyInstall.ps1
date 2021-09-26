

$ErrorActionPreference = 'Stop'
# powershell: `Get-FileHash .\Battlenet.exe -Algorithm SHA256`
$checksum = '585A0197280363E5A1CEA618CE080861994A19541EA8064B19CD409B52CBF190'

# How I got the below information:
# Open webpage where you download the windows battle.net launcher. 
# Open network developer console and wait for the download to start to your 
# computer. You will see a URL with a 200 response where the response is a bunch
# of text meaning it's probably a binary file download. 
$packageArgs = @{
  packageName   = 'battlenet'
  fileType      = 'exe'
  url           = 'https://us.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe'
  validExitCodes= @(0)
  softwareName  = 'Battle*' # name of the downloaded .exe
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs