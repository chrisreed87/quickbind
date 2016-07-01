Write-Host `n
Write-Host "The purpose of this script is to parse a block of text containing IPs and bind/unbind to the PRIMARY NIC"
Write-Host `n
Write-Host "PROCEED WITH CAUTION!"
Write-Host `n
Write-Host "Enter a string of IPs in this format 192.168.1.1,255.255.255.0 (ipaddress, subnet)"
$Blockpath = Read-Host -Prompt "Enter IP(s):"
Write-Host `n
$Selection = Read-Host -Prompt "What would you like to do, add or remove?"
Write-Host `n
If ($Selection -eq "add") {Write-Host "Binding IPs to Primary NIC"}
If ($Selection -eq "remove") {Write-Host "Removing IPs from Primary NIC"}