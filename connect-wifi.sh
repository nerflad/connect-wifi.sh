#!/bin/bash

# global defs
wificonf="/home/elb/wifi.conf"
interface="wlp58s0"

# function defs
fn_disconnect () {
    pgrep wpa_supplicant | xargs sudo kill 2>/dev/null;
    pgrep dhclient | xargs sudo kill 2>/dev/null;
    sudo ip addr flush dev $interface
}
fn_connect () {
    cat $wificonf
    read -p "Continue? (Y/n): " choice
    case $choice in
        n|N )
            echo Abort.
            echo \`$0 edit\` to change SSID/credentials.
            exit 0;;
        * )
            sudo wpa_supplicant -B nl80211 -c $wificonf -i $interface;
            echo Initializing DHCP client...
            sudo dhclient $interface;;
    esac
}
fn_usage () {
    echo Usage:
    echo $0 [connect/disconnect/show/edit]
    echo
    echo \`$0 edit\` to change SSID/credentials.
    exit 1
}

# control flow
case $1 in
    "show"|"s" )
        cat $wificonf;;
    "edit"|"e" )
        vim $wificonf;;
    "connect"|"c" )
        if pgrep wpa_supplicant > /dev/null && pgrep dhclient > /dev/null; then
            echo Reconnecting...
            fn_disconnect;
            sleep 3;
        else
            echo Connecting...
        fi
        fn_connect;;
    "disconnect"|"kill"|"d"|"k" )
        echo Disconnecting...
        fn_disconnect;;
    * )
        fn_usage;
esac
