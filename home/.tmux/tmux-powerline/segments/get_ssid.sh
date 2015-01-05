#!/bin/bash

#/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | egrep "(\ SSID)" | awk '{print $2" " $3" " $4" " $5" " $6 ;}'

function run_segment()
{
    local ssid=
    if [[ $(echo $OSTYPE | tr '[A-Z]' '[a-z]') =~ 'darwin' ]]; then
        airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
        if [ -f "$airport" ]; then
            ssid=$("$airport" -I | egrep "(\ SSID)" | awk '{print $2}')
        fi
    fi

    if [ -z "$ssid" ]; then
        ssid='no_wifi'
        echo "$ssid"
        return 1
    fi
    echo "🍣  $ssid"
    exit 0
}

get_ssid
