# $OpenBSD: dot.profile,v 1.4 2005/02/16 06:56:57 matthieu Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games:.
# This is to check the TERM and change accordingly.
# Console default term = vt220, in X = xterm
if [[ $TERM == xterm || $TERM == screen ]];
	then
		export TERM="xterm-256color";
else
		export TERM="wsvt25";
fi
COLORTERM=
export PATH HOME TERM

# This is for tmux
[ -n "$TMUX" ] && export TERM="screen-256color"

# Aliases
alias ls='colorls -G'
alias rm='rm -i'
alias mv='mv -i'
#alias mplayer='nice --19 mplayer'

# Disabling SSL check for GIT
export GIT_SSL_NO_VERIFY=true

# Set up proxy
export http_proxy="http://cbj-c-30002.asia-pac.shell.com:8080/"
export ftp_proxy="http://cbj-c-30002.asia-pac.shell.com:8080/"
export HTTP_PROXY=$http_proxy
export FTP_PROXY=$ftp_proxy
export https_proxy=$http_proxy
export ssl_proxy=$http_proxy
export gopher_proxy=$http_proxy
export socks_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1"

# Start tmux
#if [[ $TMUX = $NULL ]];
#	then
#		tmux new-session;
#else
#		tmux attach;
#fi

# This is to turn proxy on / off
function proxy {
	if [[ $1 = "on" ]];
		then
			echo "Turning proxy on...";
			export http_proxy="http://cbj-c-30002.asia-pac.shell.com:8080/"
			export ftp_proxy="http://cbj-c-30002.asia-pac.shell.com:8080/"
			export HTTP_PROXY=$http_proxy
			export FTP_PROXY=$ftp_proxy
			export https_proxy=$http_proxy
			export ssl_proxy=$http_proxy
			export gopher_proxy=$http_proxy
			export socks_proxy=$http_proxy
			export no_proxy="localhost,127.0.0.1"
	elif [[ $1 = "off" ]];
		then
			echo "Turning proxy off...";
			unset http_proxy
			unset ftp_proxy
			unset HTTP_PROXY
			unset FTP_PROXY
			unset https_proxy
			unset ssl_proxy
			unset gopher_proxy
			unset socks_proxy
	else
		echo "Usage: $0 [on|off]";
	fi
}

# This is to dial celcom3g
function celcom3g {
	# Some internal functions
	function c3gConnect {
		sudo ifconfig ppp0 create
		pppd call celcom3g &
	}
	function c3gDisconnect {
		pkill -9 pppd
		sudo ifconfig ppp0 destroy
	}
	# Dialing function
	if [[ $1 = "connect" ]];
		then
			echo "Connecting to Celcom3G...";
#			proxy off;
			c3gConnect;
	elif [[ $1 = "disconnect" ]];
		then
			echo "Disconnect from Celcom3G...";
			c3gDisconnect;
#			proxy on;
	elif [[ $1 = "restart" ]];
		then
			echo "Restarting Celcom3G connection...";
			c3gDisconnect;
			c3gConnect;
	else
		echo "Usage: $0 [connect|disconnect|restart]";
	fi
}

# This is for graphical shutdown
function shutdownx {
	actions=PowerDown,Restart,Cancel
	prompt="Please choose action:"

	action="$(xmessage -buttons "$actions" -print -center "$prompt")"

case $action in
PowerDown)
	shutdown -ph now
	;;
Restart)
	shutdown -r now
	;;
Cancel)
	exit
	;;
esac
}

# Set up proxy by auto detecting connected network.
#RESOLV_DOMAIN="clients.asia-pac.shell.com"
#grep -q $RESOLV_DOMAIN /etc/resolv.conf 2>&1 /dev/null
#if [ $? -eq 0 ];
#	then
#		export http_proxy="cbj-c-30002.asia-pac.shell.com:8080"
#		export ftp_proxy="cbj-c-30002.asia-pac.shell.com:8080"
#		echo "On Shell's network, using proxy."
#	else
#		echo "Not using proxy."
#fi	

# Start DavMail Daemon
#sudo sh ~/packages/davmail/davmail.sh &
