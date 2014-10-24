#!/bin/sh
# An Arch Linux installer by Alek Ratzloff
# Automates the tedious process of installing Arch Linux!

script_version='0.1 alpha'

echo "Arch Linux install script v$script_version"

###
# General-purpose functions
###
function prompt_yesno {
  # usage: prompt_yesno prompt variable [default]
  local prompt=$1
  local variable=$2
  local default=$3
  local answer=""

  case $default in
    'y')  prompt="$prompt [Y/n] " ;;
    'n')  prompt="$prompt [y/N] " ;;
    *)    prompt="$prompt [y/n] " ;;
  esac

  while [[ $answer == "" ]]; do
    read -r -p "$prompt" answer
    answer=${answer,,} # tolower
    
    if [[ $answer =~ ^(yes|y) ]]; then
      eval "$variable='y'"
    elif [[ $answer =~ ^(no|n) ]]; then
      eval "$variable='n'"
    else
      answer=$default
    fi
  done
}

###
# Prerequisite checking
###

# Is the user root?
user_id=$(id -u)
if [[ $user_id -ne "0" ]]; then
  echo 'Must be run as root!'
#  exit 1
fi

###
# Internet setup
###

echo "Checking internet connection..."
# Check the internet connection by pinging google.com
ping google.com -c 1 -W 1 > /dev/null
if [[ $? -eq "1" ]]; then
  # The internet connection isn't detected, so set it up
  echo "An internet connection wasn't detected. The installer will now walk you through setting up your internet connection."

  echo "TODO: set up internet connection"
fi

###
# Language/keyboard setup
###

prompt_yesno "Are you using a different keyboard layout than en_US?" resp

if [[ $resp == 'y' ]]; then
  echo 'If you know the two letter code for your keyboard layout (e.g., fr, de, ru), type it now. '
  echo 'If you want a list of keyboard codes, enter ?.'
fi
