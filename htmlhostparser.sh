#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

echo -e "\n\033[1;39m"
clear
cat << EOF
  ┌────────────────────────────────┐
  │        HTML HOST PARSER        │
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

echo -e "\n\033[1;39m   ▶▶▶ ACESSANDO PÁGINA \n"
wget --user-agent="Mozilla/5.0" -O "PAGINA" "$ALVO" 2>/dev/null 

echo -e "\033[1;39m   ▶▶▶ BUSCANDO HOSTS NA PÁGINA \033[0m\n"
grep href PAGINA | grep http | cut -d "/" -f3 | cut -d '"' -f1  | grep "\." | grep -v " " > LISTA
cat LISTA

echo -e "\n\033[1;39m   ▶▶▶ RESOLVENDO HOSTS ENCONTRADOS \033[0m\n"
for URL in $(cat LISTA)
do
host "$URL" | grep " has address " | tee -a hhp_$ALVO
done

echo -e "\n\033[1;36m   ▶▶▶ PRONTO \033[0m\n"
echo -e "\033[1;39m      ▶▶▶ RESULTADO SALVO EM:  \033[0mhhp_$ALVO\033[1;36m\n"
rm PAGINA
rm LISTA

read -p "   ▶▶▶ EXECUTAR NOVAMENTE? [y/N]  " RESPOSTA
if [ "$RESPOSTA" != "y" ]
then
	echo -e "\n\033[1;31m   ▶▶▶ ENCERRADO \033[1;36m\n"
else
	./$0
fi
