#!/bin/bash
# https://github.com/e-pke/Bash-Scripts

# Estilos
BLD="\033[1m"
RST="\033[0m"

# Cores
RED="\033[31m"
BLU="\033[36m"
STD="\033[39m"

# Função que limpa arquivos temporários
temporario() {
	rm NAMESERVER 2>/dev/null
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
}

# Script dentro de uma função
script() {
	echo -e "${BLD}${BLU}"
	temporario

	read -p "   ▶▶▶ DIGITE O ALVO:  " ALVO

	echo -e "\n${BLD}${STD}   ▶▶▶ BUSCANDO REGISTROS DO TIPO NAME SERVER ${RST}\n"
	host -t ns "$ALVO" | cut -d " " -f4 | sed 's/.$//' >> NAMESERVER
	cat NAMESERVER

	echo -e "\n${BLD}${STD}   ▶▶▶ REALIZANDO DNS ZONE TRANSFER ${RST}\n"
	for DNS in $(cat NAMESERVER); do
		echo -e "      ▶▶▶ TESTANDO:  $DNS"
		(host -l -a $ALVO $DNS ; echo "" ) | tee -a dzt_$ALVO
	done

	echo -e "${BLD}${BLU}   ▶▶▶ PRONTO ${RST}\n"
	echo -e "${BLD}${STD}      ▶▶▶ RESULTADO SALVO EM:  ${RST}dzt_$ALVO${BLD}${BLU}\n"

	temporario

	read -p "   ▶▶▶ EXECUTAR NOVAMENTE? [y/N]  " RESPOSTA
	if [[ "$RESPOSTA" != "y" ]]; then
		exit 0
	else
		script
	fi
}

header
script
