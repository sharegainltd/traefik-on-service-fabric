param($version='v1.5.4')
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
$releases=Invoke-RestMethod -Uri https://api.github.com/repos/containous/traefik/releases -Method Get -ContentType 'application/json'
$release=$releases | ?{$_.tag_name -eq $version}
$asset=$release.assets | ?{$_.name -eq 'traefik_windows-amd64.exe'}
$url=$asset.browser_download_url
$outfile = $PSScriptRoot+"/../ApplicationPackageRoot/TraefikPkg/Code/traefik.exe"
Invoke-WebRequest -Uri $url -OutFile $outfile -UseBasicParsing
& $outfile version