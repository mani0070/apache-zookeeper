$ErrorActionPreference = 'Stop';

$options = @{
  unzipLocation = 'C:\tools\'
}

$packageParameters = @{
  packageName   = 'apache-zookeeper'
  url           = 'http://apache.mirror.anlx.net/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz'
  url64bit      = ''
  checksum      = ''
  checksumType  = 'sha256'
  checksum64    = ''
  checksumType64= 'sha256'


}

function Set-ChocolateyPackageOptions {
    param(
        [Parameter(Mandatory=$True,Position=1)]
        [hashtable] $options
    )
    $packageParameters = $env:chocolateyPackageParameters;
 
    if ($packageParameters) {
        $parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")
        $parameters.GetEnumerator() | ForEach-Object {
           $options[($_.Key)] = ($_.Value)
        }
    }
}

function Get-ChocolateyPackageTempFolder {
    param(
      [string] $packageName
    )
    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "$packageName"
    if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}
    
    return $tempDir
}
 

Set-ChocolateyPackageOptions $options

$tempFolder = Get-ChocolateyPackageTempFolder $packageParameters['packageName']
$downloadFile = Join-Path $tempFolder "zookeeper-3.4.9.tar.gz"
$tarFile = Join-Path $tempFolder "zookeeper-3.4.9.tar"
Get-ChocolateyWebFile @packageParameters -FileFullPath $downloadFile

Get-ChocolateyUnzip -FileFullPath $downloadFile -Destination $tempFolder

# Untar into location folder
Get-ChocolateyUnzip -FileFullPath $tarFile -Destination $options['unzipLocation']


Export-CliXml -Path (Join-Path $PSScriptRoot 'options.xml') -InputObject $options