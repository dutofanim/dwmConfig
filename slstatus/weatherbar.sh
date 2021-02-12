#!/bin/bash

curl wttr.in/Campinas?format=j1 | sed 30q > ~/.config/weather.txt

weather=$(cat ~/.config/weather.txt | sed 20q | grep value | awk '{print $2 $3}' | sed 's/\"//g')

temp=$(cat ~/.config/weather.txt | grep temp_C | awk '{print $2}' | sed 's/\"//g' | sed 's/,//')

nocloud="盛"
cloud=""
rain=""
storm=""
lotempicon=""
midtempicon=""
hitempicon=""

#print weather info
TEMP() {
if [ "$temp" -gt 32 ]; then
	echo -e $hitempicon $temp
elif [ "$temp" -ge 20 ] && [ "$temp" -le 31 ]; then
	echo -e $midtempicon $temp
elif [ "$temp" -le 19]; then
	echo -e $lotempicon $temp
fi
}

WEATHER () {
if [[ "$weather" = "Clear" ]] || [[ "$weather" = "Sunny" ]]; then
	echo -e "$nocloud $weather"
else
	echo -e "$cloud $weather"
fi
}

echo $(WEATHER) $(TEMP)
