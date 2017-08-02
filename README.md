# dmenu-sudo-integration
A modified version of dmenu (based on dmenu2) meant to allow users to execute commands that require Sudo access using dmenu.

To start, use -I to install the script (must be root/sudo to do so). Beyond that, invoke it directly. 

Dependencies:
-dmenu2
-sudo

Requirements:
-System must include /usr/sbin/ in the PATH. Arch does by default. May need tweaking for other distros.
-Some sort of graphical enviroment (duh)

Acknowledgements:
-Dmenu_Path is bundled with this script because it is not included in dmenu2 (but is used by classic dmenu). To avoid breaking programs that rely on it, it has been included. Dmenu_Path was not written by me, but by the original authors of dmenu.

