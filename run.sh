#! /bin/bash

xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 -root &

chromium-browser --kiosk --noerrdialogs --disable-infobars https://example.com/login &

sleep 20;
echo "About to hit Tab";
xdotool keydown Tab; xdotool keyup Tab;
echo "About to hit Return";
xdotool keydown Return; xdotool keyup Return;

echo "About to load channels";
loop_channels () {
    channels=`cat channels.config`

    for channel in $channels;
    do
        chromium-browser --kiosk --noerrdialogs --disable-infobars $channel &
    done
}

loop_channels;

while true; do
    xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;

    currenttime=$(date +%H:%M)
    if [[ "$currenttime" < "01:15" ]]; then
	echo "It is $currenttime, Executing refresh...";
        xdotool keydown ctrl+r; xdotool keyup ctrl+r;
    fi

    sleep 300;
done
