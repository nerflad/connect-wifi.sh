# xpswifi
(Because I don't like netctl)


Make sure you change $wificonf to the path of your config file, and $interface
to the name of your NIC.

## Fatal Assumptions
- Bash is installed :)
- Vim is installed (and preferred) for `edit`
- No netctl/nm/whatever else mucking with network daemons behind your back
  (seriously -- I disabled/uninstalled all that stuff before I wrote this,
  so I have no idea how they play together)
- You only want to connect to WPA-encrypted networks
- You're okay with your WPA key coming across the terminal in clear text
- You don't want a static IP address
