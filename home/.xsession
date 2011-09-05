# Variables for choosing window manager to load.
managers=scrotwm,wmii,xfce4,fvwm
prompt="Welcome $USER, select window manager:"

# Selecting window manager
manager="$(xmessage -buttons "$managers" -print -center -timeout 3 "$prompt")"
# Execute the window manager
case $manager in
scrotwm)
	xscreensaver -no-splash &
	nohup sh ~/davmail/davmail.sh ~/davmail/davmail.conf &
	eval `cat ~/.fehbg`
	conky &
#	xstatbar -y 753 -w 1024 &
	exec scrotwm
	;;
wmii)
	xscreensaver -no-splash &
	nohup sh ~/davmail/davmail.sh ~/davmail/davmail.conf &
	eval `cat ~/.fehbg`
	exec wmii
	;;
xfce4)
	exec startxfce4
	;;
fvwm)
	xscreensaver -no-splash &
	nohup sh ~/davmail/davmail.sh ~/davmail/davmail.conf &
	eval `cat ~/.fehbg`
	exec fvwm
	;;
*)
	xscreensaver -no-splash &
	nohup sh ~/davmail/davmail.sh ~/davmail/davmail.conf &
	eval `cat ~/.fehbg`
	conky &
#	xstatbar -y 753 -w 1024 &
	exec scrotwm
	;;
esac
