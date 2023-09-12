#!/bin/bash

bluetoothctl power on

connect="connect"
newConnection="new connection"
disconnect="disconnect"

options="$connect\n$newConnection\n$disconnect"

mode="$(echo -e "$options" | rofi -i -p 'bluetooth manager' -dmenu)"
case $mode in
  $connect)
    selection=($(bluetoothctl devices | awk '{print $2,$3}' | rofi -i -p 'Connect:' -dmenu))
    bluetoothctl connect ${selection[0]} && notify-send "bluetooth connect to ${selection[1]}"
    ;;
  $newConnection)
    $TERM -e bluetoothctl
    ;;
  $disconnect)
    selection=($(bluetoothctl devices | awk '{print $2,$3}' | rofi -i -p 'Disconnect:' -dmenu))
    bluetoothctl disconnect ${selection[0]} && notify-send "bluetooth disconnect from ${selection[1]}"
    ;;
esac
