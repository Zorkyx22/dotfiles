#!/usr/bin/env bash
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"
entry_theme="~/.config/rofi.sire-n1chaulas/entry-style.rasi"

# This finds the nearby wifis and lists them in an easy to parse way
function get_wifi_list() {
  echo "$(nmcli --fields IN-USE,SSID,SECURITY,BARS device wifi list | sed 's/^IN-USE\s//g' | sed '/*/d' | sed 's/^ *//' | sed '/--/d')"
}

enabled="`(nmcli -f WIFI g | sed -n 2p)`"
current_ssid="`(nmcli c show --active | sed -n 2p | awk '{print $1}')`"
wifi_list="`get_wifi_list`"
current_bars="`(echo "$wifi_list" | awk -v ssid=$current_ssid '$1==ssid {print $3}')`"
if [[ "$enabled" =~ "enabled" ]]; then
  summary_string="$current_ssid  $current_bars"
else
  summary_string="Network Antenna Offline"
fi

toggle="Toggle Wifi Antenna"
disconnect="Disconnect Current Network"
connect="Connect to a Network"

manual="Manual Entry"

function rofi_cmd() {
	rofi -theme-str "window {width: 400px;}" \
		-theme-str "listview {columns: 1; lines: 3;}" \
		-theme-str "textbox-prompt-colon {str: ' ';}" \
		-theme-str 'window {location: north east; x-offset: -10px;}' \
		-dmenu \
		-p "$summary_string" \
		-markup-rows \
		-theme ${theme} 
}

function run_rofi() {
	echo -e "$toggle\n$disconnect\n$connect" | rofi_cmd
}

function show_wifi_list() {
  linenum="`(echo "$manual\n$wifi_list" | wc -l)`"
  echo -e "$wifi_list\n$manual" | tail -n +2 | uniq -u | rofi -theme-str "window {width: 600px;}" \
		-theme-str "listview {columns: 1; lines: 8;}" \
                -theme-str "textbox-prompt-colon {str: ' '; padding-right: 17px;}" \
                -lines $linenum \
		-dmenu \
                -p "Currently Connected to: $summary_string" \
                -mesg "$(echo "$wifi_list" | head -n 1)" \
		-markup-rows \
		-theme ${theme} 
}

function ask_password() {
      MPASS=$(echo -en "" | rofi -dmenu -password -p "PASSWORD" \
	-theme-str "listview {columns: 1; lines: 0;}" \
        -mesg "Enter the PASSWORD of the network" -lines 0 -theme ${entry_theme})
      echo "$MPASS"
}

function ask_ssid() {
      MSSID=$(echo -en "" | rofi -dmenu -p "SSID" -mesg "Enter the SSID of the network" \
	-theme-str "listview {columns: 1; lines: 0;}" \
        -lines 0 -theme ${entry_theme})
      echo "$MSSID"
}

function connect_to_network() {
  ssid="`(echo "$1")`"
  pass="`(echo "$2")`"
  if [ "$pass" = "" ]; then
    nmcli dev wifi con "$ssid" | notify-send
  elif [ "$ssid" != '' ] && [ "$pass" != '' ]; then
    nmcli dev wifi con "$ssid" password "$pass" | notify-send
  fi
}
# Actions
chosen="$(run_rofi)"
case ${chosen} in
  $toggle)
      if [[ "$enabled" =~ "enabled" ]]; then
        notify-send "Wifi Antenna Turning Off..."
        nmcli radio wifi off
      else
        notify-send "Wifi Antenna Turning On..."
        nmcli radio wifi on
      fi
    ;;
  $connect)
    wifi_choice=$(show_wifi_list)
    if [[ $wifi_choice =~ $manual ]]; then
      ssid=$(ask_ssid)
      pass=$(ask_password)
      connect_to_network $ssid $pass
    elif [[ $wifi_choice != "" && $wifi_choice != '' ]]; then
      pass=$(ask_password)
      connect_to_network $wifi_choice $pass
    else
      exit 0
    fi
    ;;
  $disconnect)
    if [[ $current_ssid != "" && $current_ssid != '' ]]; then
      notify-send "Disconnecting from $current_ssid..."
      nmcli c down $current_ssid
    else
      exit 0
    fi
    ;;
esac
