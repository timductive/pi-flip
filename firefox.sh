#! /bin/bash

# Set Display environment variable
export DISPLAY=:0

# close previous firefox window
wmctrl -ic "$(wmctrl -lp | grep "$(pgrep firefox)" | tail -1 | awk '{ print $1 }')"
sleep 5;

echo "Loading channels";
loop_channels () {
    channels=`cat channels.config`

    for channel in $channels;
    do
        firefox $channel &
    done
}

loop_channels;

echo "Looping channels...";
while true; do
    xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;

    currenttime=$(date +%H:%M)
    if [[ "$currenttime" < "01:15" ]]; then
        echo "It is $currenttime, Executing refresh...";
        xdotool keydown ctrl+r; xdotool keyup ctrl+r;
    fi

    sleep 300;
done
