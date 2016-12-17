$ErrorActionPreference = 'Stop';

$packageName = 'apache-zookeeper'
$softwareName = 'apache-zookeeper*'

$optionsFile = (Join-Path $PSScriptRoot 'options.xml')

Uninstall-ChocolateyZipPackage $packageName
Remove-Item (Join-Path $options['unzipLocation'] '') -Recurse -Force