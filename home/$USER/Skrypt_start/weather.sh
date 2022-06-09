#!/bin/sh
#relies on curl
#recommend putting this script in a cron job that runs at least once a day.
curl -s "https://pl.wttr.in/Łódź?format=%C+%t+%P+Wschód+%S+Zachód+%s" > ~/.config/weather.txt
