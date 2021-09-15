# rdp_over_ssh_proxy
RDP a server over SSH proxy

You have windows servers accessible over an ssh host? you need an easy way to RDP those hosts?

Usage:
rdp.ps1 -server <windows_host> -gw <ssh_proxy_server> -user <ssh_proxy_user> -rdp_user <domain>\<username> -rdp_pass <password>

All parameters except -rdp_password are mandatory, if rpd_password is ommited it will ask you interactively

Limitations:
openSSH ssh needs to be installed on the users machine, a key is needed to authenticate with the ssh proxy.
