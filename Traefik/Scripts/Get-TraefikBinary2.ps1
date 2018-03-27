param($version='v1.5.4',$watchversion='v0.0.3')
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

New-Item -ItemType Directory -Force -Path $PSScriptRoot+"/../ApplicationPackageRoot/TraefikPkg/Code" 
$releases=Invoke-RestMethod -Uri https://api.github.com/repos/containous/traefik/releases -Method Get -ContentType 'application/json'
$release=$releases | ?{$_.tag_name -eq $version}
$asset=$release.assets | ?{$_.name -eq 'traefik_windows-amd64.exe'}
$url=$asset.browser_download_url
$outfile = $PSScriptRoot+"/../ApplicationPackageRoot/TraefikPkg/Code/traefik.exe"
Invoke-WebRequest -Uri $url -OutFile $outfile -UseBasicParsing

New-Item -ItemType Directory -Force -Path $PSScriptRoot+"/../ApplicationPackageRoot/Watchdog/Code"
$watchreleases=Invoke-RestMethod -Uri https://api.github.com/repos/lawrencegripper/traefik-appinsights-watchdog/releases -Method Get -ContentType 'application/json'
$watchrelease=$watchreleases | ?{$_.tag_name -eq $watchversion}
$watchasset=$watchrelease.assets | ?{$_.name -eq 'windows_traefik-appinsights-watchdog.exe'}
$watchurl=$watchasset.browser_download_url
$watchoutfile = $PSScriptRoot+"/../ApplicationPackageRoot/Watchdog/Code/traefik-appinsights-watchdog.exe"
Invoke-WebRequest -Uri $watchurl -OutFile $watchoutfile -UseBasicParsing

& $outfile version