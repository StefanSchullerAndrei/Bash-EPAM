#!/bin/bash
#
# NumberJack: a small number-guessing game with a play/help/exit menu.

#########################
#Print the main menu.
#Arguments:
#  None
#Outputs:
#  Writes the menu to stdout
#########################
function show_menu() {
  cat <<END
    PLAY : Hit 1 and enter.
    HELP : Hit 2 and enter.
    EXIT : Hit 3 and enter.

END
}

#########################
#Print the game instructions.
#Arguments:
#  None
#Outputs
#  Writes the instructions to stdout
#########################

function show_help() {
  echo "HELP: INSTRUCTIONS TO PLAY THE GAME"
}

#########################
#Arguments:
#  None:
#Outputs:
# Writes prompts and results to stdout
#########################

function play_game() {
  local number
  local index
  local score=0
  local -a shuffled
  local -a positions

  read -r -p "Enter any nymber between 0 and 9 : " number

  while true; do
    mapfile -t shuffled < <(shuf -i 0-9 -n 10)
    positions=( {1..10} )
    echo "${shuffled[*]}"
    echo "${positions[*]}"

    if ! read -r -t 5 -p  "Enter the index of your number : " index; then
      break
    fi

    if (( shuffled[index - 1] != number )); then
      break
    fi
    echo "Great"
    (( score +=1 ))
  done

  echo -e "\nGAME OVER\n"
  echo "You scored ${score} points"
}

#######################
#Show the menu and handle the user's choice until they exit
#Arguments:
#  None
#######################

function main() {
  local choice=0

  echo -e "\n NumberJack \n"

  while [[ "${choice}" != 3 ]]; do
    show_menu
    read -r -p "Enter your choice : " choice
    case "${choice}" in
      1) play_game ;;
      2) show_help ;;
      3) ;;
      *) break ;;
    esac
  done
}

main "@"
