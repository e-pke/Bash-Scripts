#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

echo -e "\n\033[1;39m"
clear
cat << EOF
  ┌────────────────────────────────┐
  │       DNS ZONE TRANSFER        │
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

echo -e "\n\033[1;39m   ▶▶▶ BUSCANDO REGISTROS DO TIPO NAME SERVER \033[0m\n"
host -t ns "$ALVO" | cut -d " " -f4 | sed 's/.$//' >> NAMESERVER
cat NAMESERVER

echo -e "\n\033[1;39m   ▶▶▶ REALIZANDO DNS ZONE TRANSFER \033[0m\n"
for DNS in $(cat NAMESERVER)
do
echo -e "      ▶▶▶ TESTANDO:  $DNS"
(host -l -a $ALVO $DNS ; echo "" ) | tee -a dzt_$ALVO
done

echo -e "\033[1;36m   ▶▶▶ PRONTO \033[0m\n"
echo -e "\033[1;39m      ▶▶▶ RESULTADO SALVO EM:  \033[0mdzt_$ALVO\033[1;36m\n"
rm NAMESERVER

read -p "   ▶▶▶ EXECUTAR NOVAMENTE? [y/N]  " RESPOSTA
if [ "$RESPOSTA" != "y" ]
then
	echo -e "\n\033[1;31m   ▶▶▶ ENCERRADO \033[1;36m\n"
else
	./$0
fi
