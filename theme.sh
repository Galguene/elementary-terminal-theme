#!/bin/bash

if [ $# -gt 1 ]
then
echo "Too many arguments. Usage: theme (number)"
exit 1
fi

if [ $# -eq 0 ]
then
echo "Choose from themes:"
echo ""
inc=0
while IFS="," read -r name other
do
echo "$inc - $name"
inc=$(($inc+1))
done < <(tail -n +2 ~/Scripts/elementary-terminal-theme/themes.csv) # parse ignoring header with tail
exit 0
fi

max=$(wc -l < ~/Scripts/elementary-terminal-theme/themes.csv)

if [ $1 -gt $(($max-1)) ] || [ $1 -lt 0 ]
then
echo "No theme assigned to $1. To get a list of themes, use theme without arguments"
exit 1
fi

line=$(sed -n "$(($1+2))p" ~/Scripts/elementary-terminal-theme/themes.csv)
IFS=","
read name pl bg cur fg <<<"$line"
gsettings set io.elementary.terminal.settings palette $pl
gsettings set io.elementary.terminal.settings background $bg
gsettings set io.elementary.terminal.settings cursor-color $cur
gsettings set io.elementary.terminal.settings foreground $fg

