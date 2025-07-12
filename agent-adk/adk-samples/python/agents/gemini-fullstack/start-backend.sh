#!/bin/bash
# Script para iniciar o backend com as variáveis de ambiente corretas

# Navegar para o diretório do projeto
cd "$(dirname "$0")"

# Adicionar uv ao PATH
export PATH="$HOME/.local/bin:$PATH"

# Ativar o ambiente virtual
source .venv/bin/activate

# Carregar variáveis de ambiente do arquivo .env
if [ -f "app/.env" ]; then
    echo "Carregando variáveis de ambiente de app/.env..."
    export $(grep -v '^#' app/.env | xargs)
else
    echo "ERRO: Arquivo app/.env não encontrado!"
    exit 1
fi

# Verificar se as variáveis foram carregadas
echo "GOOGLE_GENAI_USE_VERTEXAI = $GOOGLE_GENAI_USE_VERTEXAI"
echo "GOOGLE_API_KEY = ${GOOGLE_API_KEY:0:10}..." # Mostra apenas os primeiros 10 caracteres

# Iniciar o servidor
echo "Iniciando servidor ADK..."
uv run adk api_server app --allow_origins="*"