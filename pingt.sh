#!/bin/bash

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
VERSION="2.0.0"
RELEASE_DATE="2018/08/19"

function Version(){
echo -e "${SNAME} ${VERSION}, ${RELEASE_DATE} release."
}

function Usage(){
echo -e "${YEL}${BOLD}Usage:${ESC}"
echo -e "${SPACE}${YEL}${BOLD}./${SNAME}${ESC} [OPTION] ${U_SCORE}IP ADDRESS${ESC}${LF}"
echo -e "Try ${YEL}${BOLD}'-h'${ESC} for more information."
}

function Help(){
echo -e "${YEL}${BOLD}NAME${ESC}"
echo -e "${SPACE}${SNAME}${LF}"

echo -e "${YEL}${BOLD}SYNOPSIS${ESC}"
echo -e "${SPACE}${YEL}${BOLD}./${SNAME}${ESC} [OPTION] ${U_SCORE}IP ADDRESS${ESC}${LF}"

echo -e "${YEL}${BOLD}EXAMPLE${ESC}"
echo -e "${SPACE}${YEL}${BOLD}$ ./${SNAME}${ESC} 8.8.8.8${LF}
[2017/03/23 13:48:20] PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
[2017/03/23 13:48:20] 64 bytes from 8.8.8.8: icmp_seq=1 ttl=37 time=1.52 ms
[2017/03/23 13:48:21] 64 bytes from 8.8.8.8: icmp_seq=2 ttl=37 time=1.22 ms
[2017/03/23 13:48:22] 64 bytes from 8.8.8.8: icmp_seq=3 ttl=37 time=0.688 ms
[2017/03/23 13:48:23] 64 bytes from 8.8.8.8: icmp_seq=4 ttl=37 time=1.29 ms${LF}"

echo -e "${YEL}${BOLD}DESCRIPTION${ESC}"
echo -e "This is ping tool which returns output with timestamp.${LF}"

echo -e "${YEL}${BOLD}OPTIONS${ESC}"
echo -e "${SPACE}${YEL}${BOLD}-c${ESC}${TAB}Count option.${LF}"
echo -e "${SPACE}${YEL}${BOLD}-t${ESC}${TAB}Using this option will ping the target until you force it to stop by using Ctrl-C.${LF}"
echo -e "${SPACE}${YEL}${BOLD}-h${ESC}${TAB}Output a usage message and exit.${LF}"
echo -e "${SPACE}${YEL}${BOLD}-v${ESC}${TAB}Output the version number and exit.${LF}"
}

function Exit(){
  echo -e "\nOK: ${OK} NG: ${NG}"
  exit 2
}

function Ping(){
  ping -c 1 -q $IPaddr > /dev/null
}

function Hantei(){
  if [ $? = 0 ]; then
    echo -n "!"; ((OK++))
  else
    echo -n "."; ((NG++))
  fi
  [ $(($counter % 50)) == 0 ] && echo ""
  sleep 0.1
}

OK=0
NG=0

case $1 in 
  -c )
    trap Exit 2 
    max=$2
    IPaddr=$3
    for counter in $(seq 1 $max); do
    Ping
    Hantei
    done
    echo -e "\nOK: ${OK} NG: ${NG}"
  ;;
  -h|--help )
    Help
  ;;
  -t )
    trap Exit 2
    IPaddr=$2
    counter=1
    while :; do
    Ping
    Hantei
    ((counter++))
    done
    echo -e "\nOK: ${OK} NG: ${NG}"
  ;;
  -v|--version )
    Version
  ;;
  * )
    if [ "$1" = "" ]; then 
      Help
    else
    IPaddr=$1
    ping ${IPaddr} | xargs -L 1 -I '{}' date '+[%Y/%m/%d %H:%M:%S] {}'
    fi
  ;;
esac
