# Makefile para execução local do ADK-Forge

.PHONY: help install playground api run test clean setup

# Ajuda padrão
help:
	@echo "ADK-Forge - Comandos disponíveis:"
	@echo ""
	@echo "  make setup      - Configuração inicial (cria .env, instala deps)"
	@echo "  make install    - Instala dependências do projeto"
	@echo "  make playground - Inicia interface web interativa (porta 8080)"
	@echo "  make api        - Inicia servidor API do ADK"
	@echo "  make run        - Executa CLI interativo do ADK-Forge"
	@echo "  make test       - Executa testes do projeto"
	@echo "  make clean      - Limpa arquivos temporários e caches"
	@echo ""
	@echo "Configuração rápida:"
	@echo "  1. make setup"
	@echo "  2. Edite adk_forge/.env com suas credenciais"
	@echo "  3. make playground (ou make run)"

# Configuração inicial
setup:
	@echo "🔧 Configurando ambiente ADK-Forge..."
	@if [ ! -f adk_forge/.env ]; then \
		cp adk_forge/.env.example adk_forge/.env; \
		echo "✅ Arquivo .env criado. Por favor, edite adk_forge/.env com suas credenciais."; \
	else \
		echo "ℹ️  Arquivo .env já existe."; \
	fi
	@make install
	@echo ""
	@echo "✨ Setup completo! Próximos passos:"
	@echo "1. Edite adk_forge/.env com sua GOOGLE_API_KEY"
	@echo "2. Execute: make playground"

# Instalar dependências
install:
	@echo "📦 Instalando dependências..."
	pip install -r requirements.txt
	@echo "✅ Dependências instaladas!"

# Interface web interativa (ADK Web)
playground:
	@echo "🌐 Iniciando ADK Web Playground..."
	@echo "📍 Acesse: http://localhost:8080"
	@echo ""
	cd adk_forge && adk web --port 8080

# API Server
api:
	@echo "🚀 Iniciando ADK API Server..."
	@echo "📍 API disponível em: http://localhost:8000"
	@echo ""
	adk api_server adk_forge --allow_origins="*"

# Executar CLI interativo
run:
	@echo "🤖 Iniciando ADK-Forge CLI..."
	@echo ""
	python -m adk_forge.main

# Executar testes
test:
	@echo "🧪 Executando testes..."
	@if [ -f test_forge.py ]; then \
		python test_forge.py; \
	else \
		echo "⚠️  test_forge.py não encontrado. Execute o ADK-Forge para gerá-lo."; \
	fi

# Limpar arquivos temporários
clean:
	@echo "🧹 Limpando arquivos temporários..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find /tmp -name "adk-forge-session-*" -mtime +1 -exec rm -rf {} + 2>/dev/null || true
	@echo "✅ Limpeza concluída!"

# Verificar configuração
check:
	@echo "🔍 Verificando configuração..."
	@echo ""
	@echo "Python: $(shell python --version)"
	@echo "Pip: $(shell pip --version)"
	@echo ""
	@if [ -f adk_forge/.env ]; then \
		echo "✅ Arquivo .env encontrado"; \
	else \
		echo "❌ Arquivo .env não encontrado (execute: make setup)"; \
	fi
	@echo ""
	@python -c "import google.adk; print('✅ Google ADK instalado')" 2>/dev/null || echo "❌ Google ADK não instalado"
	@python -c "import dotenv; print('✅ python-dotenv instalado')" 2>/dev/null || echo "❌ python-dotenv não instalado"
	@echo ""
	@which adk >/dev/null 2>&1 && echo "✅ ADK CLI disponível" || echo "❌ ADK CLI não encontrado"