$ErrorActionPreference = 'Stop';

$packageName = 'apache-zookeeper'
$softwareName = 'apache-zookeeper*'

$optionsFile = (Join-Path $PSScriptRoot 'options.xml')

Remove-Item (Join-Path $options['unzipLocation'] '') -Recurse -Force