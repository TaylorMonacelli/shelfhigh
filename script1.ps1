function Get-FileIfNotExists {
    Param (
        $Url,
        $Destination
    )

    if (-not (Test-Path $Destination)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $ProgressPreference = 'SilentlyContinue'

        Write-Verbose "Downloading $Url"
        Invoke-WebRequest -UseBasicParsing -Uri $url -Outfile $Destination
    }
    else {
        Write-Verbose "${Destination} already exists. Skipping."
    }
}

$url = "https://software-download.microsoft.com/download/pr/19042.508.200927-1902.20h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
$filename = Split-Path -Leaf -Path $url
$fileinfo = New-Object System.IO.FileInfo($filename)
$basedir = '~/Downloads'
$iso = Join-Path "${HOME}/Downloads" $filename
Get-FileIfNotExists $url $iso
$global:ProgressPreference = "SilentlyContinue"
Mount-DiskImage -ImagePath $iso

New-Item -Type "directory" -Force -Path sxs | Out-Null
Copy-Item -Force -Recurse e:/sources/sxs/* ./sxs
Get-ChildItem -Recurse ./sxs | Select-Object -Expand Fullname
