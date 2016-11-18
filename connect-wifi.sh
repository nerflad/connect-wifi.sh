#!/bin/bash

# global defs
wificonf="/home/elb/wifi.conf"

# function defs
fn_disconnect () {
    pgrep wpa_supplicant | xargs sudo kill 2>/dev/null;
    pgrep dhclient | xargs sudo kill 2>/dev/null;
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
            sudo wpa_supplicant -B -d nl80211 -c $wificonf -i wlp58s0;
            sudo dhclient wlp58s0;;
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
    "show" )
        cat $wificonf;;
    "edit" )
        vim $wificonf;;
    "connect" )
        if pgrep wpa_supplicant > /dev/null && pgrep dhclient > /dev/null; then
            echo Reconnecting...
            fn_disconnect;
            sleep 3;
        else
            echo Connecting...
        fi
        fn_connect;;
    "disconnect"|"kill" )
        echo Disconnecting...
        fn_disconnect;;
    * )
        fn_usage;
esac
