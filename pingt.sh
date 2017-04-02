#!/bin/bash
trap Msg 2

#==========================================================
# Colors
#==========================================================
BOLD='\e[01m'          # 強調
U_SCORE='\e[04m'       # 下線(アンダースコア)

RED='\e[31m'           # 赤色
YEL='\e[33m'           # 黄色
WHT='\e[37m'           # 白色

ESC='\e[m'             # エスケープシーケンス

#==========================================================
# Keys
#==========================================================
LF=$'\n'
TAB=$'\t'
SPACE='        '

#==========================================================
# Usage & Help Menu
#==========================================================
SNAME=`basename $0`
VERSION="1.0.0"
RELEASE_DATE="2017/03/23"

function Version(){
echo -e "${SNAME} ${VERSION}, ${RELEASE_DATE} release."
}

function Usage(){
echo -e "${YEL}${BOLD}Usage:${ESC}"
echo -e "${SPACE}${YEL}${BOLD}./${SNAME}${ESC} ${U_SCORE}IP ADDRESS${ESC}${LF}"
echo -e "Try ${YEL}${BOLD}'-h'${ESC} for more information."
}

function Help(){
echo -e "${YEL}${BOLD}NAME${ESC}"
echo -e "${SPACE}${SNAME}${LF}"

echo -e "${YEL}${BOLD}SYNOPSIS${ESC}"
echo -e "${SPACE}${YEL}${BOLD}./${SNAME}${ESC} ${U_SCORE}IP ADDRESS${ESC}${LF}"

echo -e "${YEL}${BOLD}EXAMPLE${ESC}"
echo -e "${SPACE}${YEL}${BOLD}$ ./${SNAME}${ESC} 8.8.8.8${LF}
[2017/03/23 13:48:20] PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
[2017/03/23 13:48:20] 64 bytes from 8.8.8.8: icmp_seq=1 ttl=37 time=1.52 ms
[2017/03/23 13:48:21] 64 bytes from 8.8.8.8: icmp_seq=2 ttl=37 time=1.22 ms
[2017/03/23 13:48:22] 64 bytes from 8.8.8.8: icmp_seq=3 ttl=37 time=0.688 ms
[2017/03/23 13:48:23] 64 bytes from 8.8.8.8: icmp_seq=4 ttl=37 time=1.29 ms"

echo -e "${YEL}${BOLD}DESCRIPTION${ESC}"
echo -e "This is ping tool which returns output with timestamp"

echo -e "${YEL}${BOLD}OPTIONS${ESC}"
echo -e "${SPACE}${YEL}${BOLD}-o${ESC}${TAB}Save the oytput to a given destination.${LF}"
echo -e "${SPACE}${YEL}${BOLD}-h${ESC}${TAB}Output a usage message and exit.${LF}"
echo -e "${SPACE}${YEL}${BOLD}-v${ESC}${TAB}Output the version number and exit.${LF}"
}

#==========================================================
# VARIABLE SETTING
#==========================================================

if [[ $# -eq 0 ]]; then
  echo -e "${YEL}${BOLD}Invalid Option${ESC}"
  Usage
  exit 1
fi

IPaddr=$1

while getopts ':o:hv' OPT
do
  case $OPT in
    "o" ) # Save output to file
	    FLG_F="TRUE" ; VALUE_F="${OPTARG}"
		;;
    "h" ) # Help option
	    Help | more
      exit 1
		;;
    "v" ) # Version option
	    Version
      exit 1
    ;;
    \? )
      echo -e "${YEL}${BOLD}Invalid Option${ESC}"
      Usage
      exit 1
    ;;
  esac
done

function Msg() {
  echo " File has been saved to ${VALUE_F}"
}

if [ "$FLG_F" = "TRUE" ]; then
  ping ${IPaddr} | xargs -L 1 -I '{}' date '+[%Y/%m/%d %H:%M:%S] {}' | tee ${VALUE_F}
else
  ping ${IPaddr} | xargs -L 1 -I '{}' date '+[%Y/%m/%d %H:%M:%S] {}'
fi
