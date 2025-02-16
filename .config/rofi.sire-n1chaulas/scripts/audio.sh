#!/usr/bin/env bash
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

volume_s="`wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'`"
volume_m="`wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2 * 100}'`"
volume_str="Speaker: $volume_s% --- Mic: $volume_m%"

status_s="`wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}'`"
status_m="`wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $3}'`"
if [[ $status_m == '' ]]; then
	micon=''
else
	micon=''
fi

if [[ $status_s == '' ]]; then
	sicon=''
else
	sicon=''
fi

sinks="`wpctl status |\
        awk 'BEGIN { A=0; S=0; }
            /^Audio/ { A=1; }
            /Sinks/ { S=1; }
            /Sink endpoints/ { S=0; }
            /^Video/ { A=0; }
            { if (A==1 && S==1 && / [[:digit:]]*\./)
                 { print; } }' |
        sed 's/^.* \([[:digit:]]*\)\. \(.*\) \[.*$/\1\t\2/'`"


# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: 400px;}" \
		-dmenu \
		-theme-str "listview {columns: 1; lines: 5;}" \
		-theme-str "textbox-prompt-colon {str: '$sicon    $micon';}" \
		-theme-str 'window {location: north east; x-offset: -10px;}' \
		-mesg "$volume_str" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$sinks" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
echo "$chosen"
if [[ $chosen != '' ]]; then
	awk '{print $1}' $chosen | wpctl set-default
fi
