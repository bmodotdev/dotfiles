# Ansi color code variables
blue="\e[0;94m"
cyan="\e[1;96m"
green="\e[0;92m"
purple="\e[1;95m"
red="\e[0;91m"
yellow="\e[1;93m"
white="\e[0;97m"

expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"

bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

function strip_ansi () {
    read -r line;
    printf '%s\n' "${line//$'\e'\[*([0-9;])m/}"
}
