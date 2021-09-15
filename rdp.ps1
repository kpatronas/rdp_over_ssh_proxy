param([Parameter(Mandatory=$True)]$server,
      [Parameter(Mandatory=$True)]$gw,
      [Parameter(Mandatory=$True)]$user,
      [Parameter(Mandatory=$True)]$rdp_user,
      [Parameter(Mandatory=$False)]$rdp_pass)

while($True)
{
 $lport     = (Get-Random -Minimum 4097 -Maximum 65535)
 $port_used = (Get-NetTCPConnection | where Localport -eq $lport)
 if(!$port_used)
 {
   break
 }
}

$tunnel       = Start-Process ssh   -ArgumentList "-N -l $user $gw -L ${lport}:${server}:3389" -Verb open -PassThru -windowstyle hidden
$tunnel_is_up = Get-process | where Id -eq $tunnel.Id

if($tunnel_is_up)
{ 
 cmdkey /generic:localhost /user:${rdp_user} /pass:${rdp_pass}
 $rdp    = Start-Process mstsc -ArgumentList "/f /V:localhost:${lport}" -PassThru
}

while($True)
{
 Sleep 5
 $is_running = Get-process | where Id -eq $rdp.Id
 if(!$is_running)
 {
   $tunnel | Stop-Process -Force
   cmdkey /delete:localhost > $null
   break
 }
}
