#!/bin/bash
isInvalidate=1
dmenuArgs=""
allowSudo=1
while test $# -gt 0; do
	case "$1" in
		-P|--Persist)
			isInvalidate=0
			shift
			;;
		-N|--NoSudo)
			allowSudo=0
			shift
			;;
		-A|--Args)
			shift
			if test $# -gt 0; then
				dmenuArgs=$1
			else
				echo -e "No Arguments Detected, Failing"
				exit 1
			fi
			shift
			;;
		-H|--Help)
			shift
			exit 0
			;;
		-I|--Install)
			DIR=$(dirname "$(readlink -f "$0")")
			NAME=$(echo "$0" | sed -e "s/.\//\//")
			rm /usr/sbin/dmenu_sudo_wrapper
			cp "$DIR$NAME" /usr/sbin/dmenu_sudo_wrapper
			chown -h root /usr/sbin/dmenu_sudo_wrapper
			chmod 755 /usr/sbin/dmenu_sudo_wrapper
			echo -e "Installed"
			dmenu_sudo_wrapper -A "-p \"Installed [ESC to Exit]\""
			exit 0
			;;
		"[sudo] password for root: ")
			dmenu -mask -p "$1" <&- && echo
			exit 0
			;;
	esac
done

rawPrompt="dmenu_path | dmenu"
userCommand=$(eval "$rawPrompt $dmenuArgs")

if [ "$allowSudo" -eq 0 ]; then
	if [[ $userCommand == "sudo "* ]]; then
		echo "Sudo not allowed. Failing."
		exit 1
	fi
fi

if [ "$isInvalidate" -eq 1 ]; then
	if [[ $userCommand == "sudo"* ]]; then
		userCommand="$userCommand; sudo -k"
	fi
fi

userCommand=$(echo "$userCommand" | sed -e "s/sudo/SUDO_ASKPASS=\"\/usr\/sbin\/dmenu_sudo_wrapper\" sudo -A /")
eval "$userCommand"
exit 0

