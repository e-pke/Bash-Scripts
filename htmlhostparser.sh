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
	rm PAGINA 2>/dev/null
	rm LISTA 2>/dev/null
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
}

# Script dentro de uma função
script() {
	echo -e "${BLD}${BLU}"
	temporario
	
	read -p "   ▶▶▶ DIGITE O ALVO:  " ALVO

	echo -e "\n${BLD}${STD}   ▶▶▶ ACESSANDO PÁGINA \n"
	wget --user-agent="Mozilla/5.0" -O "PAGINA" "$ALVO" 2>/dev/null 

	echo -e "${BLD}${STD}   ▶▶▶ BUSCANDO HOSTS NA PÁGINA ${RST}\n"
	grep href PAGINA | grep http | cut -d "/" -f3 | cut -d '"' -f1  | grep "\." | grep -v " " > LISTA
	cat LISTA

	echo -e "\n${BLD}${STD}   ▶▶▶ RESOLVENDO HOSTS ENCONTRADOS ${RST}\n"
	for URL in $(cat LISTA); do
		host "$URL" | grep " has address " | tee -a hhp_$ALVO
	done

	echo -e "\n${BLD}${BLU}   ▶▶▶ PRONTO ${RST}\n"
	echo -e "${BLD}${STD}      ▶▶▶ RESULTADO SALVO EM:  ${RST}hhp_$ALVO${BLD}${BLU}\n"

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
