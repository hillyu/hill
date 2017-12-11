#!/bin/sh

MESSAGE=$(cat)

# escape single quote in sed requires special treatment so use ascii code instead.
# only keep first grep result, filter out from field in the reply messages.
#filter *reply* message header as no-replay...
NEWALIAS=$(echo "${MESSAGE}" | grep ^"From: " | grep -iv "reply"|head -n 1|sed s/[\,\"\']//g | awk '{$1=""; if (NF == 3) {print "alias" $0;} else if (NF == 2) {print "alias" $0 $0;} else if (NF > 3) {print "alias", tolower($(NF-1))"-"tolower($2) $0;}}')


if grep -Fxq "$NEWALIAS" $HOME/.config/mutt/aliases.txt; then
    :
else
    echo "$NEWALIAS" >> $HOME/.config/mutt/aliases.txt
fi

echo "${MESSAGE}"
