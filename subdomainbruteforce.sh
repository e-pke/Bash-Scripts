#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

testar() { printf "\r      ▶▶▶ TESTANDO:  %-50s" "$1" >&2; }
limpar() { printf "\r\033[K" >&2; }

echo -e "\n\033[1;39m"
clear
cat << EOF
  ┌────────────────────────────────┐
  │     SUBDOMAIN BRUTE FORCE      │
  └────────────────────────────────┘

       ▄▄▄▄▄▄       ▄▄▄▄      by 
      ██▀▀▀▀▀█       ██          
      ██▄▄▄▄ ▀ ██▀█▄ ██ ▄█▀▄█▀█▄ 
      ██▀▀▀▀ ▄ ██ ██ ████  ██▄█▀ 
      ▀██████▀ ██▄█▀▄██ ▀█▄▀█▄▄■ 
     ▄▄▄▄▄▄▄▄▄ ██ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
               ▀▀                
EOF
echo -e "\033[1;36m\n"

read -p "   ▶▶▶ DIGITE O ALVO:  " ALVO
read -p "   ▶▶▶ DIGITE A WORDLIST:  " WORDLIST

echo -e "\n\033[1;39m   ▶▶▶ TESTANDO SUBDOMÍNIOS \033[0m\n"
for PALAVRA in $(cat $WORDLIST)
do
testar "$PALAVRA.$ALVO"
DNS=$(host "$PALAVRA.$ALVO" | egrep -v "not found")
if [ "$DNS" != "" ]
then
limpar
echo "$DNS" | tee -a sbf_$ALVO
fi
done
limpar

echo -e "\n\033[1;36m   ▶▶▶ PRONTO \033[0m\n"
echo -e "\033[1;39m      ▶▶▶ RESULTADO SALVO EM:  \033[0msbf_$ALVO\033[1;36m\n"

read -p "   ▶▶▶ EXECUTAR NOVAMENTE? [y/N]  " RESPOSTA
if [ "$RESPOSTA" != "y" ]
then
	echo -e "\n\033[1;31m   ▶▶▶ ENCERRADO \033[1;36m\n"
else
	./$0
fi
