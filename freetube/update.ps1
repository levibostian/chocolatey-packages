import-module au

# can't use /latest to get latest release because pre-releases do not appear in that list. 
$release = 'https://api.github.com/repos/FreeTubeApp/FreeTube/releases'

function global:au_BeforeUpdate() {
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(^[$]url\s*=\s*)('.*')"   = "`$1'$($Latest.Url)'"
        }
     }
}

function global:au_GetLatest {
    $latest_release = Invoke-WebRequest -Uri $release -Headers @{"accept"="application/vnd.github.v3+json"} | ConvertFrom-Json

    # https://stackoverflow.com/a/51173792
    $latest_release[0].name -match "\d+.\d+.\d+"
    $version = $Matches[0]

    $url = ""
    Foreach ($asset in $latest_release[0].assets ) { 
        if ($asset.name -match ".+setup-x64.exe") {
            $url = $asset.browser_download_url
        }
    }
 
    return @{ Version = $version; Url = $url }
}

# uncomment below for production
update -NoCheckUrl -ChecksumFor None

# uncomment below for testing
# global:au_GetLatest