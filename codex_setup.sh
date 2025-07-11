#!/usr/bin/env bash
# Setup script adaptado para Codex Cloud
# Coloque este conteúdo em Settings > Setup Script

set -e  # aborta se algo falhar
set -x  # loga cada comando

# Navegar para raiz do projeto
cd /workspace

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

# 3. Criar estrutura base de diretórios
echo "📁 Criando estrutura de diretórios..."
mkdir -p adk_forge/{agents,tools}
mkdir -p docs
mkdir -p tests

# 4. Verificar instalação
echo "✅ Verificando instalação..."
python -c "import google.auth; print('✓ Google Auth instalado')"
python -c "import google.cloud.aiplatform; print('✓ Google Cloud AI Platform instalado')"
python -c "import pydantic; print('✓ Pydantic instalado')"

echo "🎉 Setup concluído com sucesso!"
echo "📋 Consulte AGENTS.md para contexto do projeto"
echo "📋 Consulte manifest.json para tarefas a implementar"