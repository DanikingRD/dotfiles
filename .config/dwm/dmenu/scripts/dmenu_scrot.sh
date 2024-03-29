#!/usr/bin/env bash

# Packages: dmenu_scrot, maim, libnotify, xclip
# ***This script was made by Clay Gomera (Drake)***
#  - Description: A simple screenshot/screencast dmenu script
#  - Dependencies: maim, splop, ffmpeg, dmenu, libnotify

###########################
## Screenshots Directory ##
###########################
# SHOTDIR="$MEDIA_DIR/pictures/screenshots" # $MEDIA_DIR reffers to a global variable in .xinitrc/.bash_profile
SHOTDIR="$HOME/pictures/screenshots" # $MEDIA_DIR reffers to a global variable in .xinitrc/.bash_profile
mkdir -p "$SHOTDIR"

#######################
## Main menu choices ##
#######################
mcho1="󰹑 Take an screenshot"
mcho2="󰻃 Record the screen"
mchos="$mcho1\n$mcho2"

#############################
## Screenshot menu choices ##
#############################
scho1="󱣴 Entire screen"
scho2="󱎫 Entire screen with delay"
scho3="󱕻 Select area"
scho4="󰖯 Active window"
scho5="󱎘 Exit"
schos="$scho1\n$scho2\n$scho3\n$scho4\n$scho5"

########################
## Screenshot submenu ##
########################
sscho1="󰆏 Copy to clipboard"
sscho2="󰠘 Save to ~/pictures/screenshots"
sschos="$sscho1\n$sscho2"

#################################
## Screenshot delay subsubmenu ##
#################################
del1="󱑀 3 sec delay"
del2="󱑂 5 sec delay"
del3="󱑇 10 sec delay"
dels="$del1\n$del2\n$del3"

#####
## This function uses the sschos variable
## to ask the user what to do with the
## screenshot
#####
## param: none
## return: string
#####
fsschos() {
  sschoice=$(echo -e "$sschos" | dmenu -i -l 2 -p "  What do you want to do with this screenshot?")
}

#####
## This function uses the dels variable
## to ask the user which delay option to
## choose
#####
## param: none
## return: string
#####
fdel() {
  del=$(echo -e "$dels" | dmenu -i -p " Select Delay")
}

#####
## This function does a full screen
## screenshot without delay, depending on
## what the user chooses on the fsschos
## function, the screenshot will be saved
## to the clipboard or to $SHOTDIR
#####
## param: none
## return: void
#####
shot_screen() {
  fsschos
  if [ "$sschoice" = "$sscho1" ]; then
    maim | xclip -selection clipboard -t image/png && notify-send "Screenshot saved to clipboard"
  elif [ "$sschoice" = "$sscho2" ]; then
    maim -f jpg "$SHOTDIR/$(date +%s).jpg" && notify-send "Screenshot saved"
  else
    exit 0
  fi
}

#####
## This function does a full screen
## screenshot with delay, depending on
## what the user chooses on the fsschos
## function, the screenshot will be saved
## to the clipboard or to $SHOTDIR. And
## depending on what the user chooses on
## the fdel function, the delay will be
## between 3 and 10 seconds
#####
## param: none
## return: void
#####
shot_screen_delay() {
  fsschos;
  if [ "$sschoice" = "$sscho1" ]; then
    fdel;
    case $del in
      "$del1")
        sleep 3 && maim | xclip -selection clipboard -t image/png && notify-send "Screenshot saved to clipboard";
        ;;
      "$del2")
        sleep 5 && maim | xclip -selection clipboard -t image/png && notify-send "Screenshot saved to clipboard";
        ;;
      "$del3")
        sleep 10 && maim | xclip -selection clipboard -t image/png && notify-send  "Screenshot saved to clipboard";
    esac
  elif [ "$sschoice" = "$sscho2" ]; then
    fdel;
    case $del in
      "$del1")
        sleep 3 && maim -f jpg "$SHOTDIR/$(date +%s).jpg" && notify-send "Screenshot saved to ~/pictures/screenshots/";
        ;;
      "$del2")
        sleep 5 && maim -f jpg "$SHOTDIR/$(date +%s).jpg" && notify-send "Screenshot saved to ~/pictures/screenshots/";
        ;;
      "$del3")
        sleep 10 && maim -f jpg "$SHOTDIR/$(date +%s).jpg" && notify-send "Screenshot saved to ~/pictures/screenshots/";
    esac
  else
    exit 0
  fi
}

#####
## This function allows the user to select
## the area on screen to screenshot
## depending on what the user chooses on
## the fsschos function, the screenshot
## will be saved to the clipboard or to
## $SHOTDIR
#####
## param: none
## return: void
#####
shot_area() {
  fsschos;
  if [ "$sschoice" = "$sscho1" ]; then
    maim -s | xclip -selection clipboard -t image/png && notify-send "Screenshot saved to clipboard";
  elif [ "$sschoice" = "$sscho2" ]; then
    maim -s -f jpg "$SHOTDIR/$(date +%s).jpg" && notify-send "Screenshot saved to ~/Media/Pictures/Screenshots/";
  else
    exit 0
  fi
}

#####
## This function does an screnshot of the
## currently active window, depending on
## what the user chooses on the fsschos
## function, the screenshot will be saved
## to the clipboard or to $SHOTDIR
#####
## param: none
## return: void
#####
shot_window() {
  fsschos;
  if [ "$sschoice" = "$sscho1" ]; then
    maim -i "$(xdotool getactivewindow)" | xclip -selection clipboard -t image/png && notify-send "Screenshot saved to clipboard";
  elif [ "$sschoice" = "$sscho2" ]; then
    maim -i "$(xdotool getactivewindow)" -f jpg "$SHOTDIR/$(date +%s).jpg" && notify-send "Screenshot saved to ~/Media/Pictures/Screenshots/";
  else
    exit 0
  fi
}

##########
## main ##
##########
mchoice=$(echo -e "$mchos" | dmenu -i -l 2 -p "  Screen Capture Menu") # main menu prompt
case $mchoice in
  "$mcho1")
    schoice=$(echo -e "$schos" | dmenu -i -l 9 -p "  Sreenshot Menu") # screenshot menu prompt
    case $schoice in
      "$scho1")
        shot_screen;
        ;;
      "$scho2")
        shot_screen_delay;
        ;;
      "$scho3")
        shot_area;
        ;;
      "$scho4")
        shot_window;
        ;;
      "$scho5")
        exit 0
    esac
    ;;
  "$mcho2")
    # TODO Implement screencast functionality with ffmpeg
    notify-send "Bro you need to implement screen recording with ffmpeg"
    exit 0
    ;;
esac
