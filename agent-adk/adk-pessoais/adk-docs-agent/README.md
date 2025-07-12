# ADK Documentation Agent

Um agente especializado em buscar informações exclusivamente na documentação oficial do Google Agent Development Kit (ADK).

## 🎯 Objetivo

Este agente foi criado para responder perguntas sobre o Google ADK consultando APENAS a documentação oficial em https://google.github.io/adk-docs/, garantindo respostas precisas e confiáveis sobre:

- Arquitetura e classes do ADK
- Como criar agentes customizados
- Sistema de tools e callbacks
- Melhores práticas de desenvolvimento
- Configuração e deployment

## 🚀 Como Usar

### Pré-requisitos
- Python 3.10+
- uv (gerenciador de pacotes)
- Google AI Studio API Key

### Instalação

1. Navegue até o diretório do agente:
```bash
cd /Users/institutorecriare/VSCodeProjects/prof/prof/agent-adk/adk-pessoais/adk-docs-agent
```

2. Instale as dependências:
```bash
export PATH="$HOME/.local/bin:$PATH"
make install
```

### Execução

#### Opção 1: Interface Web (Recomendado para testes)
```bash
make playground
```
Acesse http://localhost:8501

#### Opção 2: API Server
```bash
make dev
```
Use com o frontend do gemini-fullstack em http://localhost:5173/app/

## 🔧 Como Funciona

### Ferramenta Customizada
O agente usa uma ferramenta especial `search_adk_docs()` que automaticamente adiciona o filtro `site:google.github.io/adk-docs/` a todas as pesquisas, garantindo que apenas resultados da documentação oficial sejam retornados.

### Agentes Especializados
- **adk_plan_generator**: Cria planos de pesquisa focados em ADK
- **adk_docs_researcher**: Executa pesquisas exclusivamente nos docs oficiais
- **adk_interactive_planner**: Interface principal com o usuário

## 📝 Exemplos de Uso

```
"Como criar um agente customizado no ADK?"
"Quais são as principais classes do ADK Python?"
"Como implementar callbacks em agentes ADK?"
"Explique o sistema de tools do ADK"
"Como fazer deploy de um agente ADK no Vertex AI?"
```

## 🐛 Correção Importante

Este agente já inclui a correção para o bug de carregamento do arquivo `.env`. Se você encontrar o erro de credenciais, verifique se:
1. O arquivo `app/.env` existe e contém suas chaves
2. `python-dotenv` está instalado
3. O `config.py` está carregando o `.env` corretamente

## 🔍 Diferenças do Agente Original

1. **Busca Restrita**: Todas as pesquisas são automaticamente filtradas para o domínio oficial
2. **Prompts Especializados**: Focados em terminologia e conceitos do ADK
3. **Nomes Descritivos**: Agentes renomeados para refletir especialização
4. **Documentação Clara**: Este README explica o propósito específico

## 📚 Recursos Adicionais

- [Documentação Oficial do ADK](https://google.github.io/adk-docs/)
- [Repositório do ADK Python](https://github.com/google/adk-python)
- [Samples do ADK](https://github.com/google/adk-samples)