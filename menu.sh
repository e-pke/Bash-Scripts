#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

# Estilos
BLD="\033[1m"
RST="\033[0m"

# Cores
RED="\033[31m"
BLU="\033[36m"
STD="\033[39m"

# Script dentro de uma função
script() {
	clear
	echo -e "${BLD}${STD}\n"
	cat <<- EOF
	  ┌────────────────────────────────┐
	  │          BASH SCRIPTS          │
	  └────────────────────────────────┘

	       ▄▄▄▄▄▄       ▄▄▄▄      by 
	      ██▀▀▀▀▀█       ██          
	      ██▄▄▄▄ ▀ ██▀█▄ ██ ▄█▀▄█▀█▄ 
	      ██▀▀▀▀ ▄ ██ ██ ████  ██▄█▀ 
	      ▀██████▀ ██▄█▀▄██ ▀█▄▀█▄▄■ 
	     ▄▄▄▄▄▄▄▄▄ ██ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
	               ▀▀                

	   ▶▶▶ 1  HTML Host Parser
	   ▶▶▶ 2  Subdomain Brute Force
	   ▶▶▶ 3  DNS Zone Transfer
	   ▶▶▶ 4  HTTP Brute Force
   
	   ▶▶▶ x  ENCERRAR
EOF
	echo -e "${BLD}${BLU}\n"

	read -p "   ▶▶▶ SELECIONE O SCRIPT:  " OPT

	case "$OPT" in
		1)
		clear ; chmod +x htmlhostparser.sh ; ./htmlhostparser.sh
		;;
		2)
		clear ; chmod +x subdomainbruteforce.sh ; ./subdomainbruteforce.sh
		;;
		3)
		clear ; chmod +x dnszonetransfer.sh ; ./dnszonetransfer.sh
		;;
		4)
		clear ; chmod +x httpbruteforce.sh ; ./httpbruteforce.sh
		;;
		5|X|x)
		echo -e "\n\n${BLD}${RED}   ▶▶▶ ENCERRADO ${BLD}${BLU}"
		;;
		*)
		echo -e "\n${BLD}${RED}   ▶▶▶ OPÇÃO INVÁLIDA:  "$OPT" ${BLD}${BLU}"
		sleep 0.8s
		clear
		script
		;;
	esac
}

script
