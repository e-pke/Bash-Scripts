#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

# Estilos
BLD="\033[1m"
RST="\033[0m"

# Cores
RED="\033[31m"
BLU="\033[36m"
STD="\033[39m"

# Função para mostrar o que está sendo testado
testar() {
	printf "\r      ▶▶▶ TESTANDO:  %-50s" "$1" >&2
}

# Função para limpar a linha após o teste
limpar() {
	printf "\r\033[K" >&2
}

# Função para encerrar o script mesmo com Ctrl+C
encerrar() {
	echo -e "\n\n${BLD}${RED}   ▶▶▶ ENCERRADO ${BLD}${BLU}"
}
trap encerrar exit

# Função cabeçalho
header() {
	echo -e "\n${BLD}${STD}"
	cat <<- EOF
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
}

# Script dentro de uma função
script() {
	echo -e "${BLD}${BLU}"

	read -p "   ▶▶▶ DIGITE O ALVO:  " ALVO
	read -p "   ▶▶▶ DIGITE A WORDLIST:  " WORDLIST
	read -p "   ▶▶▶ DIGITE A EXTENSÃO:  " EXT

	echo -e "\n${BLD}${STD}   ▶▶▶ PROCURANDO DIRETÓRIOS ${RST}\n"
	for PALAVRA in $(cat $WORDLIST); do
		testar "$ALVO/$PALAVRA/"
		DIR=$(curl -s -H "User-Agent: Mozilla" -o /dev/null -w "%{http_code}" "$ALVO/$PALAVRA/")
		if [[ "$DIR" == "200" ]]; then
			limpar
			echo "$ALVO/$PALAVRA/" | tee -a hbf_$ALVO
		fi
	done
	limpar

	echo -e "\n${BLD}${STD}   ▶▶▶ PROCURANDO ARQUIVOS ${RST}\n"
	for PALAVRA in $(cat $WORDLIST); do
		testar "$ALVO/$PALAVRA"
		FILE=$(curl -s -H "User-Agent: Mozilla" -o /dev/null -w "%{http_code}" "$ALVO/$PALAVRA")
		if [[ "$FILE" == "200" ]]; then
			limpar
			echo "$ALVO/$PALAVRA" | tee -a hbf_$ALVO
		fi
	done
	limpar

	echo -e "\n${BLD}${STD}   ▶▶▶ PROCURANDO ARQUIVOS .$EXT ${RST}\n"
	for PALAVRA in $(cat $WORDLIST); do
		testar "$ALVO/$PALAVRA.$EXT"
		FILE=$(curl -s -H "User-Agent: Mozilla" -o /dev/null -w "%{http_code}" "$ALVO/$PALAVRA.$EXT")
		if [[ "$FILE" == "200" ]]; then
			limpar
			echo "$ALVO/$PALAVRA.$EXT" | tee -a hbf_$ALVO
		fi
	done
	limpar

	echo -e "\n${BLD}${BLU}   ▶▶▶ PRONTO ${RST}\n"
	echo -e "${BLD}${STD}      ▶▶▶ RESULTADO SALVO EM:  ${RST}hbf_$ALVO${BLD}${BLU}\n"

	read -p "   ▶▶▶ EXECUTAR NOVAMENTE? [y/N]  " RESPOSTA
	if [[ "$RESPOSTA" != "y" ]]; then
		exit 0
	else
		script
	fi
}

header
script
