#!/bin/bash
cd "$(dirname "$0")"
echo "🚀 Iniciando LLM Auditor..."
echo ""
echo "Escolha o modo de execução:"
echo "1) Interface de linha de comando (CLI)"
echo "2) Interface web (localhost:8000)"
echo ""
read -p "Digite sua escolha (1 ou 2): " choice

case $choice in
    1)
        echo "Iniciando CLI..."
        poetry run adk run llm_auditor
        ;;
    2)
        echo "Iniciando interface web em http://localhost:8000"
        echo "Pressione CTRL+C para parar"
        poetry run adk web
        ;;
    *)
        echo "Opção inválida. Execute novamente e escolha 1 ou 2."
        exit 1
        ;;
esac