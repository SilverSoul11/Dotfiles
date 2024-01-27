# /usr/etc/X11/xinit/xinitrc.common
#
# Common code used in X session and X init scripts.
# File shall be sourced but not executed by the scripts.
#

#
# Source this file only once
#
test "$XSESSION_IS_UP" != "yes" || return
XSESSION_IS_UP=yes
export XSESSION_IS_UP

#
# Some common user and system files,
#
    XETCDIR=/etc/X11
 XUSRETCDIR=/usr/etc/X11
  xdefaults=$HOME/.Xdefaults
 xresources=$HOME/.Xresources
    xmodmap=$HOME/.Xmodmap
     xkbmap=$HOME/.Xkbmap

#
# This should be the default
#
TERM=xterm
export TERM

#
# Check for X11R6 in execution path
#
case ":${PATH}:" in
    *:/usr/X11R6/bin:*) ;;
    *)	PATH="${PATH}:/usr/X11R6/bin"
esac

#
# Run user xinit scripts.
#
for script in /usr/etc/X11/xinit/xinitrc.d/* \
              /etc/X11/xinit/xinitrc.d/*; do
    test -e $script || continue
    test -d $script && continue
    # higher priority for /etc/X11/xinit/xinitrc.d ...
    if echo $script | grep -q ^/usr; then
        sname=$(basename $script)
        test -e /etc/X11/xinit/xinitrc.d/$sname && continue
    fi
    case "$script" in
	.*)		continue ;;
	*.rpm*)		continue ;;
	*.swap)		continue ;;
	*.bak)		continue ;;
	*.orig)		continue ;;
	\#*)		continue ;;
	*~)		continue ;;
    esac
    if test -x $script ; then
	if grep -qE "^# to be sourced" $script >/dev/null 2>&1; then
	    . $script
	else
	    # run number ordered scripts sequentially
	    case ${script##*/} in
	    	 [0-9][0-9]-*)  $script ;;
		 *) $script & ;;
	    esac
	fi
    else
	. $script
    fi
done
unset script

#
# Choose a window manager if not set by /etc/profile.d/profile.sh
#
if test -z "$WINDOWMANAGER" ; then
	# For some reason, $WINDOWMANAGER is not set.
	# This is because the user cleared it or DEFAULT_WM is empty.
	# Fall back on any session we can find.
	_find_wm()
	{
		local file
		local dir="/usr/share/xsessions"

		# Pick a session description file.
		for file in ${dir}/{plasma*,kde*,gnome*,xfce*,lxde*,icewm*,*}.desktop
		do
			case "${file##*/}" in
				# Ignore user's .xsession as we can't
				# handle it as a fallback.
				xsession.*)
					continue ;;
			esac
			test -e "$file" && break
		done
		test -z "$file" && return

		# Grab the session command line from the file.
		local line
		while read -r line
		do
			case ${line} in
				Exec=*)
					WINDOWMANAGER="${line#Exec=}"
					break
					;;
			esac
		done < "$file"
	}
	_find_wm
	unset _find_wm
fi

#
# Error, no Window Manager found.  Normally the exit
# raise the fallback trap of the sourcing script.
#
if test -z "$WINDOWMANAGER" ; then
    if test -t 1 ; then
	echo "Error: Unable to find a window manager. Please make sure you installed one!"
	echo "       This could be due to a misconfigured WINDOWMANAGER in your shell,"
	echo "       an unknown DEFAULT_WM in /etc/sysconfig/windowmanager, or because"
	echo "       the programs referenced in /usr/share/xsessions/*.desktop are"
	echo "       not in the PATH."
	echo "Exiting..."
    fi
    xmessage -timeout 20 -default okay -center -file - <<-EOF
	Error: Unable to find a window manager. Please make sure you installed one!
	       This could be due to a misconfigured WINDOWMANAGER in your shell,
	       an unknown DEFAULT_WM in /etc/sysconfig/windowmanager, or because
	       the session program referenced in /usr/share/xsessions/*.desktop is
	       not in the PATH.
	Exiting...
	EOF
    exit 1
fi

#
# Foreign X session scripts may use an other variable name
#
WINDOW_MANAGER=$WINDOWMANAGER
STARTUP=$WINDOWMANAGER
export WINDOWMANAGER WINDOW_MANAGER STARTUP

#
# Start the XIM server
#
if [ -r /etc/X11/xim ]; then
    XIMFILE=/etc/X11/xim
elif [ -r /usr/etc/X11/xim ]; then
    XIMFILE=/usr/etc/X11/xim
fi
test -r $HOME/.xim && XIMFILE=$HOME/.xim
test -r $XIMFILE   && source $XIMFILE

#
# Enable Numlock if set
#
if test -r /var/run/numlock-on && type -p numlockx > /dev/null ; then
    numlockx
fi

#
# Load nvidia settings
#
if test -r $HOME/.nvidia-settings-rc && type -p nvidia-settings > /dev/null ; then
    nvidia-settings --load-config-only > /dev/null 2>&1 &
fi

#
# Handle system's and/or user's Xkbmap (x)or user's Xmodmap.
# Note that xkb and xmodmap should not be mixed.
# Priority: 1. User's xkb -> 2. User's xmodmap -> 3. System's xkb
#
if test -s "$xkbmap" ; then
    # apply system's xkb first
    if test -s $XETCDIR/Xkbmap; then
        test -r $XETCDIR/Xkbmap && cat $XETCDIR/Xkbmap | xkbcomp - $DISPLAY
    elif test -s $XUSRETCDIR/Xkbmap; then
        test -r $XUSRETCDIR/Xkbmap && cat $XUSRETCDIR/Xkbmap | xkbcomp - $DISPLAY
    fi
    test -r "$xkbmap"  && cat "$xkbmap" | xkbcomp - $DISPLAY
elif test -s "$xmodmap"; then
    test -r "$xmodmap" && xmodmap "$xmodmap"
elif test -s $XETCDIR/Xkbmap ; then
    test -r $XETCDIR/Xkbmap && cat $XETCDIR/Xkbmap | xkbcomp - $DISPLAY
elif test -s $XUSRETCDIR/Xkbmap ; then
    test -r $XUSRETCDIR/Xkbmap && cat $XUSRETCDIR/Xkbmap | xkbcomp - $DISPLAY
fi

#
# Handle the system and the users Xresources
#
if test -r "$xdefaults"  ; then
    if test -r $XETCDIR/Xresources ; then
	xrdb -nocpp -load   -retain $XETCDIR/Xresources
	xrdb -I$HOME -merge "$xdefaults"
    elif test -r $XUSRETCDIR/Xresources ; then
        xrdb -nocpp -load   -retain $XUSRETCDIR/Xresources
        xrdb -I$HOME -merge "$xdefaults"
    else
	xrdb -I$HOME -load -retain "$xdefaults"
    fi
    if test -r "$xresources" ; then
	xrdb -I$HOME -merge "$xresources"
    fi
elif test -r "$xresources" ; then
    if test -r $XETCDIR/Xresources ; then
	xrdb -nocpp -load  -retain $XETCDIR/Xresources
	xrdb -I$HOME -merge "$xresources"
    elif test -r $XUSRETCDIR/Xresources ; then
        xrdb -nocpp -load  -retain $XUSRETCDIR/Xresources
        xrdb -I$HOME -merge "$xresources"
    else
	xrdb -I$HOME -load -retain "$xresources"
    fi
elif test -r $XETCDIR/Xresources ; then
    xrdb -nocpp -load -retain $XETCDIR/Xresources
elif test -r $XUSRETCDIR/Xresources ; then
    xrdb -nocpp -load -retain $XUSRETCDIR/Xresources
fi

# prevent gnome-session from failing (boo#1163262)
export XDG_SESSION_TYPE=x11

#
# Disable new Xcursor themes if none is specified resp. located
# in $HOME (use "unset XCURSOR_CORE" to enable them again later)
#
#if test -z "$XCURSOR_THEME" -a ! -d $HOME/.icons ; then
#    XCURSOR_CORE=true
#    export XCURSOR_CORE
#else
#    unset XCURSOR_CORE
#fi
#
exec i3
