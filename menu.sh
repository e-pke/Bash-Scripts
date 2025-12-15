#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

echo -e "\033[1;39m"
clear
cat << EOF
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
echo -e "\033[1;36m\n"

chmod +x htmlhostparser.sh
chmod +x subdomainbruteforce.sh
chmod +x dnszonetransfer.sh
chmod +x httpbruteforce.sh

read -p "   ▶▶▶ SELECIONE O SCRIPT:  " OPT

case "$OPT" in
	1)
	./htmlhostparser.sh
	;;
	2)
	./subdomainbruteforce.sh
	;;
	3)
	./dnszonetransfer.sh
	;;
	4)
	./httpbruteforce.sh
	;;
	5|X|x)
	echo -e "\n\033[1;31m   ▶▶▶ ENCERRADO \033[1;36m\n"
	exit 0
	;;
	*)
	echo -e "\n\033[1;31m   ▶▶▶ OPÇÃO INVÁLIDA:  "$OPT" \033[1;36m\n"
	./menu.sh
	;;
esac
