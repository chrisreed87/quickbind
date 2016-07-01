Clear-Host
Write-Host "The purpose of this script is to quickly bind/unbind to the PRIMARY NIC `nthe PANIC option removes EVERY IP that is not the source/primary"
Write-Host `n
Write-Host "PROCEED WITH CAUTION & CHOOSE WISELY!"
Write-Host `n

#-----------User Prompt----------------------------#

$Selection = Read-Host -Prompt "What would you like to do? add, remove, or panic?"

Write-Host `n
Write-Host "If you selected panic, just hit ENTER at IP selection`nOtherwise add an IP and hit ENTER after each one, hit ENTER again when finished"

#------------Variables -----------------------------#

$newipaddress = @()
do {
 $input = (Read-Host "Enter the IP address")
 if ($input -ne '') {$newipaddress += $input}
}
until ($input -eq '')

$secondaryIPs = Get-NetIPAddress -InterfaceAlias Primary -SkipAsSource $True -ErrorAction SilentlyContinue |  foreach { $_.IPAddress }

#--------------Commands------------------------------#

#If Selection is to Add
If ($Selection -eq "add") {Write-Host "Binding IPs to Primary NIC";
$IPs = @($newipaddress) |`
   Foreach-object {
   netsh Int IPv4 Add Address Primary $_ SkipAsSource=True Mask=255.255.0.0
   write-host "$_ Added $?"
}
}

#If Selection is to Remove
If ($Selection -eq "remove") {Write-Host "Removing IPs from Primary NIC";
$IPs = @($newipaddress) |`
   Foreach-object {
   netsh Int IPv4 Delete Address Primary $_
   write-host "$_ Removed $?"
}
}

#If Selection is to Panic
if ($Selection -eq "panic") {$Confirmation=Read-Host -Prompt "Are you sure? Do you know what this means? Y or N"}

if ($Confirmation -eq "Y") { 
$panic= @($secondaryIPs) | `
    Foreach-object {
    netsh Int IPv4 Delete Address Primary $_
    write-host "$_ Removed $?"
}
}

if ($Confirmation -ne "Y") {Write-Host "Have a nice life"}

#END
