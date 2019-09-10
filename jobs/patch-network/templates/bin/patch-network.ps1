$hnsInterfaceCreated = $false
do {
  Start-Sleep -Seconds 1
  $hnsInterfaceCreated = (Get-NetAdapter).Where({$_.Name -Eq "vEthernet (Ethernet0)"}).Count -gt 0
} while ($hnsInterfaceCreated -eq $false)

$config = (cat /var/vcap/bosh/settings.json | ConvertFrom-JSON).networks.default

netsh interface ip set address "vEthernet (Ethernet0)" static $config.ip $config.netmask $config.gateway

do {
  Start-Sleep -Seconds 1000
} while ($true)
