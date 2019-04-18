#!/bin/bash

if [ -z "$1" ]
then 
    echo "No password provided, try lpass now ..."
    PASS=$(lpass show --password Astri)
else
PASS=$1
fi
MUTTAUTH="$HOME/.config/mutt/passwd.gpg"
PRINTERAUTH="/etc/samba/printing.auth"
# set muttrc gpg encrypted pass
gpg -dq $MUTTAUTH | sed 's/".*"/"'$PASS'"/g' | gpg --recipient $(id -nu) -o $MUTTAUTH --encrypt - 
# set samba printing service pass /etc/samba/printing.auth
sudo sed -i 's/password = .*/password = '$PASS'/g' /etc/samba/printing.auth
# set .config/script/email email checker in keyring using python keyring.
#python -c "import keyring; keyring.set_password('i3blocks-email', 'xcyu@astri.org', '$PASS')"
#echo $PASS |secret-tool store --label="'Password for 'xcyu@astri.org' on 'i3blocks-email'" username xcyu@astri.org
printf $PASS |secret-tool store --label="'Password for 'xcyu@astri.org' on 'i3blocks-email'" username xcyu@astri.org application 'Python keyring library' service i3blocks-email #use printf as echo will append a
#newline at the end.
#now to change corporate wifi passwd
wpa_cli -i wlp4s0 password $(wpa_cli list_networks|awk '/ASTRI_WIFI/ {print $1}') $PASS && wpa_cli -i wlp4s0 save_config 
