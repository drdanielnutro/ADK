# Agente de Pesquisa Educacional - Isabela

Um agente especializado em buscar informações em fontes educacionais, governamentais e acadêmicas confiáveis para auxiliar estudantes em suas pesquisas escolares.

## 🎯 Objetivo

Este agente foi criado para ajudar Isabela (14 anos) e outros estudantes a realizar pesquisas escolares usando APENAS fontes confiáveis e aprovadas, incluindo:

- Sites governamentais oficiais (Brasil, EUA, ONU, etc.)
- Universidades renomadas (Harvard, Oxford, USP, UFMG)
- Organizações internacionais (NASA, UN)
- Fontes de notícias confiáveis (BBC, CNN)

## 📚 Sites Aprovados

O agente busca informações exclusivamente nestes domínios:

### Governos
- 🇺🇸 usa.gov - Governo dos Estados Unidos
- 🇪🇬 egypt.gov.eg - Governo do Egito
- 🇲🇽 gob.mx - Governo do México
- 🇧🇷 gov.br - Governo do Brasil
- 🇵🇦 gob.pa - Governo do Panamá
- 🇨🇳 gov.cn - Governo da China
- 🇯🇵 japan.go.jp - Governo do Japão
- 🇷🇺 government.ru - Governo da Rússia
- 🇿🇦 gov.za - Governo da África do Sul
- 🇸🇦 my.gov.sa - Governo da Arábia Saudita
- 🇦🇺 australia.gov.au - Governo da Austrália
- 🇮🇱 gov.il - Governo de Israel

### Universidades
- 🎓 harvardmagazine.com - Harvard University
- 🎓 ox.ac.uk - University of Oxford
- 🎓 ufmg.br - Universidade Federal de Minas Gerais
- 🎓 jornal.usp.br - Universidade de São Paulo

### Organizações Internacionais
- 🌍 un.org / news.un.org - Organização das Nações Unidas
- 🚀 nasa.gov - NASA

### Mídia Confiável
- 📰 bbc.com - BBC News
- 📰 cnn.com / cnnbrasil.com.br - CNN

## 🚀 Como Usar

### Pré-requisitos
- Python 3.10+
- uv (gerenciador de pacotes)
- Google AI Studio API Key

### Instalação

1. Navegue até o diretório do agente:
```bash
cd /Users/institutorecriare/VSCodeProjects/prof/prof/agent-adk/adk-pessoais/adk-isabela
```

2. Instale as dependências:
```bash
make install
```

### Configuração

Crie o arquivo `app/.env` com suas credenciais:
```
GOOGLE_GENAI_USE_VERTEXAI=FALSE
GOOGLE_API_KEY=sua_chave_aqui
```

### Execução

#### Opção 1: Interface Web (Recomendado)
```bash
make playground
```
Acesse http://localhost:8501

#### Opção 2: API Server
```bash
make dev
```
Acesse http://localhost:8000

## 🔧 Como Funciona

### Ferramenta de Busca Educacional
O agente usa a função `search_educational_sources()` que automaticamente filtra todas as pesquisas para mostrar apenas resultados dos sites aprovados, garantindo informações confiáveis e apropriadas para trabalhos escolares.

### Fluxo de Pesquisa
1. **Planejamento**: O agente cria um plano de pesquisa baseado na pergunta
2. **Busca**: Realiza buscas apenas nos sites aprovados
3. **Síntese**: Organiza as informações de forma clara e educacional
4. **Citações**: Sempre inclui as fontes para referência

## 📝 Exemplos de Uso

### História
- "Como foi a independência do Brasil?"
- "Quais foram as causas da Segunda Guerra Mundial?"
- "O que foi a Revolução Industrial?"

### Ciências
- "Como funciona o sistema solar?"
- "O que é fotossíntese?"
- "Explique a teoria da evolução"

### Geografia
- "Quais são os principais rios do Brasil?"
- "Como se formam os vulcões?"
- "O que são placas tectônicas?"

### Atualidades
- "Quais são os objetivos da ONU?"
- "O que a NASA está pesquisando atualmente?"
- "Notícias recentes sobre mudanças climáticas"

## 🎯 Benefícios para Estudantes

1. **Fontes Confiáveis**: Apenas sites oficiais e verificados
2. **Linguagem Apropriada**: Respostas adaptadas para estudantes do ensino médio
3. **Citações Corretas**: Sempre inclui as fontes para trabalhos escolares
4. **Pesquisa Eficiente**: Economiza tempo ao buscar em múltiplas fontes confiáveis
5. **Aprendizado Seguro**: Evita informações falsas ou inadequadas

## ⚠️ Importante

- Este agente NÃO busca em sites genéricos ou não verificados
- Todas as informações vêm de fontes oficiais e acadêmicas
- Ideal para trabalhos escolares que exigem fontes confiáveis
- As respostas são formatadas para fácil compreensão

## 🔍 Diferenças do Agente Original

Este agente foi adaptado do ADK Documentation Agent com as seguintes mudanças:

1. **Múltiplos Sites**: Busca em 23 domínios confiáveis ao invés de um único
2. **Foco Educacional**: Prompts adaptados para contexto escolar
3. **Linguagem Jovem**: Comunicação apropriada para adolescentes
4. **Variedade de Fontes**: Governos, universidades, mídia e organizações internacionais

## 💡 Dicas de Uso

- Seja específico nas perguntas
- Indique a matéria quando relevante
- Peça comparações ou resumos quando necessário
- Solicite explicações em linguagem simples quando o tema for complexo