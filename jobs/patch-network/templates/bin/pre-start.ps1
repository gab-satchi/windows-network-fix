netsh interface ip dump > "C:\var\vcap\data\netsh_dump"
$n = Get-NetIPConfiguration | select IPv4Address, IPv4DefaultGateway, DNSServer
ForEach( $a in $n ){
    $a.Ipv4Address =  $a.Ipv4Address.IpAddress
		$a.Ipv4DefaultGateway = $a.Ipv4DefaultGateway.NextHop
    $a.DNSServer = $a.DNSServer.where({$_.AddressFamily -eq 2}).ServerAddresses
    $a.Netmask = (Get-NetIPAddress).Where({$_.IPAddress -eq $a.IPv4Address}).
}

$n
$n | ConvertTo-Json > "C:\var\vcap\data\original_network_config"
