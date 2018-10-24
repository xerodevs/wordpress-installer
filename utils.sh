#!/bin/bash

# Printer with shell colors
function utils.printerok {
    # BASH COLORS
    GREEN='\033[0;32m'
    RESET='\033[0m'
    if [[ ! -z "$2" ]]; then
        # print new line before
        echo ""
    fi
    echo -e "${GREEN}[✓] $1${RESET}"
}

function utils.printererr {
    # BASH COLORS
    RED='\033[0;31m'
    RESET='\033[0m'
    if [[ ! -z "$2" ]]; then
        # print new line before
        echo ""
    fi
    echo -e "${RED}[✘✘✘] $1${RESET}"
}

function utils.printerinput {
    # BASH COLORS
    CYAN='\033[0;36m'
    RESET='\033[0m'
    if [[ ! -z "$2" ]]; then
        # print new line before
        echo ""
    fi
    echo -e "${CYAN}[>] $1${RESET}"
}


function utils.printerinfo {
    # BASH COLORS
    CYAN='\033[0;33m'
    RESET='\033[0m'
    if [[ ! -z "$2" ]]; then
        # print new line before
        echo ""
    fi
    echo -e "${CYAN}[!] $1${RESET}"
}