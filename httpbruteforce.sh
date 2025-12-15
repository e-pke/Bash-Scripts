#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

testar() { printf "\r      ▶▶▶ TESTANDO:  %-50s" "$1" >&2; }
limpar() { printf "\r\033[K" >&2; }

echo -e "\n\033[1;39m"
clear
cat << EOF
  ┌────────────────────────────────┐
  │        HTTP BRUTE FORCE        │
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
read -p "   ▶▶▶ DIGITE A EXTENSÃO:  " EXT

echo -e "\n\033[1;39m   ▶▶▶ PROCURANDO DIRETÓRIOS \033[0m\n"
for PALAVRA in $(cat $WORDLIST)
do
testar "$ALVO/$PALAVRA/"
DIR=$(curl -s -H "User-Agent: Mozilla/5.0" -o /dev/null -w "%{http_code}" "$ALVO/$PALAVRA/")
if [ "$DIR" == "200" ]
then
limpar
echo "$ALVO/$PALAVRA/" | tee -a hbf_$ALVO
fi
done
limpar

echo -e "\n\033[1;39m   ▶▶▶ PROCURANDO ARQUIVOS \033[0m\n"
for PALAVRA in $(cat $WORDLIST)
do
testar "$ALVO/$PALAVRA"
FILE=$(curl -s -H "User-Agent: Mozilla/5.0" -o /dev/null -w "%{http_code}" "$ALVO/$PALAVRA")
if [ "$FILE" == "200" ]
then
limpar
echo "$ALVO/$PALAVRA" | tee -a hbf_$ALVO
fi
done
limpar

echo -e "\n\033[1;39m   ▶▶▶ PROCURANDO ARQUIVOS .$EXT \033[0m\n"
for PALAVRA in $(cat $WORDLIST)
do
testar "$ALVO/$PALAVRA.$EXT"
FILE=$(curl -s -H "User-Agent: Mozilla/5.0" -o /dev/null -w "%{http_code}" "$ALVO/$PALAVRA.$EXT")
if [ "$FILE" == "200" ]
then
limpar
echo "$ALVO/$PALAVRA.$EXT" | tee -a hbf_$ALVO
fi
done
limpar

echo -e "\n\033[1;36m   ▶▶▶ PRONTO \033[0m\n"
echo -e "\033[1;39m      ▶▶▶ RESULTADO SALVO EM:  \033[0mhbf_$ALVO\033[1;36m\n"

read -p "   ▶▶▶ EXECUTAR NOVAMENTE? [y/N]  " RESPOSTA
if [ "$RESPOSTA" != "y" ]
then
	echo -e "\n\033[1;31m   ▶▶▶ ENCERRADO \033[1;36m\n"
else
	./$0
fi
