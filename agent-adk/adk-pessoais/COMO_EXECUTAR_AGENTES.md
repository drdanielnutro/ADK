# Como Executar os Agentes ADK

Este guia explica como executar cada agente sem conflitos.

## 🤖 LLM Auditor

**Localização**: `/Users/institutorecriare/VSCodeProjects/ADK/agent-adk/adk-pessoais/llm-auditor/`

**Gerenciador**: Poetry

### Execução:
```bash
cd /Users/institutorecriare/VSCodeProjects/ADK/agent-adk/adk-pessoais/llm-auditor
./run_agent.sh
```

**Portas**:
- CLI: Interativo no terminal
- Web: http://localhost:8000

## 🔍 ADK Documentation Agent

**Localização**: `/Users/institutorecriare/VSCodeProjects/ADK/agent-adk/adk-pessoais/adk-docs-agent/`

**Gerenciador**: uv

### Execução:
```bash
cd /Users/institutorecriare/VSCodeProjects/ADK/agent-adk/adk-pessoais/adk-docs-agent
./run_adk_docs.sh
```

**Portas**:
- Web: http://localhost:8501
- API: http://localhost:8000

## ⚠️ Importante

- Execute apenas **um agente por vez**
- Cada agente tem seu próprio ambiente virtual isolado
- Não há conflito entre eles quando executados separadamente

## 🔧 Comandos Diretos (se preferir)

### LLM Auditor:
```bash
# CLI
poetry run adk run llm_auditor

# Web
poetry run adk web
```

### ADK Docs Agent:
```bash
# Web (porta 8501)
$HOME/.local/bin/uv run python -m google.adk.cli web --port 8501

# API Server
$HOME/.local/bin/uv run python -m google.adk.cli api_server app --allow_origins="*"
```