

$ErrorActionPreference = 'Stop'
# powershell: `Get-FileHash .\Battlenet.exe -Algorithm SHA256`
$checksum = '2DBBE3C5C5F88F4BE7A36A8C8D6FB7998F55E6D54C15CDDFC9DB9BFDD8F01F45'

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