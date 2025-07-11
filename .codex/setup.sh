#!/usr/bin/env bash
set -e  # aborta se algo falhar

# Navegar para raiz do projeto
cd "$(dirname "$0")/.."

echo "🔧 Setup do ADK-Forge"
echo "===================="
echo ""

# Verificar se existe manifest_local.json
if [ -f "manifest_local.json" ]; then
    echo "📋 Manifestos disponíveis:"
    echo "  1) manifest.json (Codex Cloud)"
    echo "  2) manifest_local.json (Execução Local)"
    echo ""
    read -p "Qual manifest deseja usar? (1/2) [2]: " choice
    choice=${choice:-2}
    
    case $choice in
        1)
            MANIFEST="manifest.json"
            echo "✅ Usando manifest.json (Codex Cloud)"
            ;;
        2)
            MANIFEST="manifest_local.json"
            echo "✅ Usando manifest_local.json (Execução Local)"
            ;;
        *)
            echo "❌ Opção inválida. Usando manifest_local.json"
            MANIFEST="manifest_local.json"
            ;;
    esac
else
    MANIFEST="manifest.json"
    echo "ℹ️  Usando manifest.json (único disponível)"
fi

echo ""

# 1. Criar e ativar ambiente virtual Python
if [ ! -d "venv" ]; then
    echo "🐍 Criando ambiente virtual Python..."
    python3 -m venv venv
fi

echo "🔄 Ativando ambiente virtual..."
source venv/bin/activate

# 2. Instalar dependências Python do ADK-Forge
echo "📦 Instalando dependências..."
pip install --upgrade pip
pip install -r requirements.txt

# 3. Verificar tipo de execução baseado no manifest escolhido
if [ "$MANIFEST" = "manifest_local.json" ]; then
    echo ""
    echo "📌 Configuração para execução local detectada!"
    echo ""
    echo "Próximos passos:"
    echo "1. Execute as tarefas do manifest_local.json"
    echo "2. Configure o arquivo .env com suas credenciais"
    echo "3. Use 'make playground' ou 'adk web' para executar"
    echo ""
    echo "Para mais detalhes, consulte LOCAL_EXECUTION_GUIDE.md"
else
    # Execução original para Codex Cloud
    if [ ! -f .codex/.bootstrap_done ]; then
        echo "🚀 Executando geração via manifest.json..."
        if [ -f "run_manifest.py" ]; then
            python run_manifest.py
            touch .codex/.bootstrap_done
        else
            echo "⚠️  run_manifest.py não encontrado"
            echo "   Este setup é para uso com Codex Cloud"
        fi
    else
        echo "✅ Bootstrap já executado"
    fi
fi

echo ""
echo "✨ Setup concluído!"