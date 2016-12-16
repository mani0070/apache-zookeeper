$ErrorActionPreference = 'Stop';

$packageName = 'apache-zookeeper'
$softwareName = 'apache-zookeeper*'

Uninstall-ChocolateyZipPackage $packageName