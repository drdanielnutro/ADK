# Guia de Execução Local do ADK-Forge

## 🚀 Início Rápido

```bash
# 1. Configuração inicial
make setup

# 2. Editar credenciais
nano adk_forge/.env

# 3. Executar interface web
make playground
```

## 📋 Pré-requisitos

- Python 3.10+
- pip
- Google AI Studio API Key ou credenciais Vertex AI

## 🔧 Configuração Detalhada

### 1. Obter Credenciais

#### Opção A: Google AI Studio (Mais Simples)
1. Acesse [Google AI Studio](https://aistudio.google.com/apikey)
2. Crie uma API Key
3. Copie a chave

#### Opção B: Vertex AI (Produção)
```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project SEU_PROJETO_ID
```

### 2. Configurar Ambiente

```bash
# Criar arquivo de configuração
cp adk_forge/.env.example adk_forge/.env

# Editar com suas credenciais
# Para AI Studio:
GOOGLE_GENAI_USE_VERTEXAI=FALSE
GOOGLE_API_KEY=sua_chave_aqui

# Para Vertex AI:
GOOGLE_GENAI_USE_VERTEXAI=TRUE
GOOGLE_CLOUD_PROJECT=seu-projeto
```

### 3. Instalar Dependências

```bash
make install
# ou
pip install -r requirements.txt
```

## 🎮 Modos de Execução

### Interface Web (Recomendado)
```bash
make playground
# Acesse: http://localhost:8080
```

**Recursos:**
- Interface visual interativa
- Debug em tempo real
- Visualização do fluxo de agentes

### API Server
```bash
make api
# API em: http://localhost:8000
```

**Uso:**
```bash
curl -X POST http://localhost:8000/generate \
  -H "Content-Type: application/json" \
  -d '{"specification": "{\"project\": \"Test Agent\"}"}'
```

### CLI Interativo
```bash
make run
# ou
python -m adk_forge.main
```

### Execução Direta Python
```python
from adk_forge.main import ADKForgeRunner
import asyncio

async def run():
    runner = ADKForgeRunner()
    result = await runner.process_specification(
        user_id="local-user",
        session_id="test-001",
        specification='{"project": "Hello Agent"}'
    )
    print(result)

asyncio.run(run())
```

## 📁 Estrutura do Projeto

```
ADK/
├── Makefile              # Comandos de execução
├── manifest_local.json   # Tarefas para execução local
├── requirements.txt      # Dependências Python
└── adk_forge/
    ├── .env             # Suas credenciais (não versionado)
    ├── .env.example     # Template de configuração
    ├── config.py        # Carregamento de configurações
    ├── main.py          # Runner principal
    ├── agent.py         # Definição do root_agent
    ├── __init__.py      # Exporta root_agent
    ├── agents/          # Agentes do sistema
    └── tools/           # Ferramentas customizadas
```

## 🧪 Testando a Configuração

```bash
# Verificar instalação
make check

# Teste básico
python -c "from adk_forge.config import config; print('Config OK')"

# Teste de importação
python -c "from adk_forge import root_agent; print('Import OK')"
```

## 🐛 Solução de Problemas

### "API Key não encontrada"
```bash
# Verifique o arquivo .env
cat adk_forge/.env

# Certifique-se que não há espaços extras
GOOGLE_API_KEY=sua_chave_sem_espacos
```

### "ModuleNotFoundError: adk_forge"
```bash
# Execute do diretório raiz
cd /caminho/para/ADK
python -m adk_forge.main
```

### "Permission denied"
```bash
# Para Vertex AI, faça login
gcloud auth application-default login
```

### Debug Detalhado
```bash
# Ative logs verbosos no .env
ADK_LOG_LEVEL=DEBUG
DEBUG=True
```

## 🔄 Fluxo de Desenvolvimento

1. **Editar código** dos agentes/ferramentas
2. **Testar localmente** com `make playground`
3. **Debug visual** na interface web
4. **Iterar rapidamente** sem redeploy

## 📝 Exemplo de Especificação

```json
{
  "project": "Customer Support Bot",
  "description": "Bot de atendimento ao cliente",
  "capabilities": [
    "responder_perguntas",
    "buscar_documentacao",
    "escalar_problemas"
  ],
  "tools": {
    "search": "vertex_ai_search",
    "memory": "conversation_history"
  }
}
```

## 🎯 Próximos Passos

1. **Implementar os agentes** seguindo o tutorial
2. **Testar com especificações** diferentes
3. **Ajustar prompts** conforme necessário
4. **Deploy para produção** quando pronto

## 💡 Dicas

- Use `make clean` para limpar arquivos temporários
- O sandbox é criado em `/tmp/adk-forge-session-*`
- Logs detalhados ajudam no debug
- A interface web é ótima para entender o fluxo

## 🔗 Recursos

- [Documentação ADK](https://google.github.io/adk-docs/)
- [Google AI Studio](https://aistudio.google.com/)
- [Vertex AI](https://cloud.google.com/vertex-ai)