#!/bin/bash

readonly RED='\e[31m'
readonly BLUE='\e[34m'
readonly YELLOW='\e[33m'
readonly GREEN='\e[32m'
readonly CYAN='\e[96m'
readonly GRAY='\e[37m'
readonly NC='\e[0m'
readonly BOLD='\e[1m'

function cecho () {
    local color
    color=$1
    local text
    text=$2

    case $color in
        "red") echo -e "${RED}$text${NC}"
        ;;
        "blue") echo -e "${BLUE}$text${NC}"
        ;;
        "green") echo -e "${GREEN}$text${NC}"
        ;;
        "yellow") echo -e "${YELLOW}$text${NC}"
        ;;
        "cyan") echo -e "${CYAN}$text${NC}"
        ;;
        "gray") echo -e "${GRAY}$text${NC}"
        ;;
        "red-bold") echo -e "${RED}${BOLD}$text${NC}"
        ;;
        "blue-bold") echo -e "${BLUE}${BOLD}$text${NC}"
        ;;
        "green-bold") echo -e "${GREEN}${BOLD}$text${NC}"
        ;;
        "yellow-bold") echo -e "${YELLOW}${BOLD}$text${NC}"
        ;;
        "cyan-bold") echo -e "${CYAN}${BOLD}$text${NC}"
        ;;
        "gray-bold") echo -e "${GRAY}${BOLD}$text${NC}"
        ;;
        *) echo -e "$text"
        ;;
    esac
    
}
