$ErrorActionPreference = 'Stop';

$options = @{
  unzipLocation = 'C:\tools\'
}

$packageParameters = @{
  packageName   = 'apache-zookeeper'
  url           = 'http://archive.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz'
  checksum      = '0285717bf5ea87a7a36936bf37851d214a32bb99'
  checksumType  = 'sha1'

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