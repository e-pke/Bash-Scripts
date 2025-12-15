# Bash Scripts
Repositório de Scripts em Bash.

## Como executar:
  1. Baixe os arquivos
     `git clone https://github.com/e-pke/Bash-Scripts`
  2. Dê permissão de execução ao script menu
     `chmod +x menu.sh`
  3. Execute o script
     `./menu.sh`

## Síntese dos Scripts:
**1 - HTML HOST PARSER**
- Solicita a URL alvo ao usuário
- Baixa o código-fonte da página usando wget
- Extrai e lista os domínios encontrados nos links
- Resolve os domínios para seus respectivos endereços IP
- Limpa arquivos temporários e salva o resultado em arquivo hhp_\<alvo>
  
**2 - SUBDOMAIN BRUTE FORCE**
- Solicita ao usuário o domínio alvo e o caminho da wordlist
- Gera subdomínios combinando cada palavra da wordlist com o domínio informado
- Realiza consultas DNS para verificar a existência dos subdomínios
- Exibe e salva apenas os subdomínios válidos em um arquivo sbf_\<alvo>
  
**3 - DNS ZONE TRANSFER**
- Solicita ao usuário o domínio alvo
- Consulta e lista os registros DNS do tipo NS do domínio
- Tenta realizar transferência de zona DNS em cada nameserver identificado
- Exibe e salva os resultados no arquivo dzt_\<alvo>
- Remove o arquivo temporário utilizado durante o processo
  
**4 - HTTP BRUTE FORCE**
- Solicita o alvo (URL base), a wordlist e a extensão de arquivo
- Testa a existência de diretórios (/palavra/)
- Testa a existência de arquivos (/palavra)
- Testa a existência de arquivos com extensão específica (/palavra.ext)
- Valida os resultados com base no código HTTP retornado
- Exibe e salva apenas os caminhos válidos no arquivo hbf_\<alvo>
