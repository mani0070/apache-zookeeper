$ErrorActionPreference = 'Stop';
$tempDir    = "$toolsDir\temp"
$options = @{
  unzipLocation = 'C:\tools\'
}

$packageParameters = @{
  packageName   = 'apache-zookeeper'
  url           = 'http://apache.mirror.anlx.net/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz'
  url64bit      = ''
  softwareName  = 'apache-solr*'
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

Set-ChocolateyPackageOptions $options
Install-ChocolateyZipPackage $packageParameters['packageName'] $packageParameters['url'] $tempDir $packageParameters['url64']

$tarFile = Join-Path $tempDir "zookeeper-3.4.9.tar.gz"
# Untar into tools folder
Get-ChocolateyUnzip -PackageName $packageParameters['packageName'] -FileFullPath "$tarFile" -Destination $options['unzipLocation']

Export-CliXml -Path (Join-Path $PSScriptRoot 'options.xml') -InputObject $options