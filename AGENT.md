# ADK‑Forge – Guia Rápido de Agentes

> **Propósito** — Este arquivo concentra, em um único lugar, o *quem faz o quê* dentro do repositório **adk\_forge**. Ele ajuda novos colaboradores (ou agentes automáticos) a localizar rapidamente cada classe, entender seu papel no pipeline e saber como testar.

---

## Estrutura de Pastas (essencial)

```
adk_forge/
├── agent.py               # 🚩 root_agent declarado aqui
├── __init__.py            # exporta root_agent
├── main.py                # Runner CLI
│
├── agents/
│   ├── __init__.py        # ADKForgeGenerationPipeline
│   ├── orchestrator.py    # OrchestratorAgent
│   ├── architect.py       # SystemsArchitectAgent
│   ├── developer.py       # DeveloperAgent
│   └── reviewer.py        # ReviewerAgent
│
├── tools/
│   └── file_tools.py      # create_directory, write_file, read_file
│
└── tests/
    └── test_forge.py      # teste ponta‑a‑ponta
```

---

## Descrição dos Agentes

| Classe (arquivo)                                                 | Tipo              | `output_key`              | Responsabilidade-chave                                                                   |
| ---------------------------------------------------------------- | ----------------- | ------------------------- | ---------------------------------------------------------------------------------------- |
| **OrchestratorAgent**<br>`adk_forge/agents/orchestrator.py`      | `LlmAgent`        | `orchestrator_validation` | Validar especificação JSON/Mermaid e inicializar sandbox da sessão. **Não** cria código. |
| **SystemsArchitectAgent**<br>`adk_forge/agents/architect.py`     | `LlmAgent`        | `architectural_plan`      | Converter requisitos em plano de arquitetura JSON com lista de agentes e arquivos.       |
| **DeveloperAgent**<br>`adk_forge/agents/developer.py`            | `LlmAgent`        | `development_log`         | Transformar o plano em código real usando as ferramentas de I/O seguras.                 |
| **ReviewerAgent**<br>`adk_forge/agents/reviewer.py`              | `LlmAgent`        | `review_report`           | Ler artefatos criados, verificar conformidade ADK e emitir relatório Markdown.           |
| **ADKForgeGenerationPipeline**<br>`adk_forge/agents/__init__.py` | `SequentialAgent` | —                         | Executar architect → developer → reviewer em ordem.                                      |
| **root\_agent**<br>`adk_forge/agent.py`                          | `SequentialAgent` | —                         | Orquestrador geral = OrchestratorAgent + Pipeline. CLI e deploy apontam para ele.        |

---

## Comandos Úteis

### 1. Executar localmente

```bash
python -m adk_forge.main
```

Interaja via CLI: cole a especificação JSON ou Mermaid quando solicitado.

### 2. Rodar teste rápido de importação

```bash
python -c "from adk_forge import root_agent; print('✅ import ok')"
```

### 3. Teste ponta‑a‑ponta (assíncrono)

```bash
pytest -q tests/test_forge.py
```

### 4. Validar manifesto + lint

```bash
python run_manifest.py      # executor descrito no README/manifest
flake8 adk_forge            # se configurado
```

---

## Boas‑Práticas Rápidas

1. **Sempre documente novas ferramentas** no `tools/` com docstring explicativa e parâmetro `tool_context`.
2. **Nunca** esqueça de atualizar `__all__` em `adk_forge/agents/__init__.py` quando criar agente novo.
3. Antes de um **deploy Cloud Run**, execute:

   ```bash
   adk validate adk_forge/
   docker build -t adk-forge:local .
   ```
4. Se o deploy falhar, consulte `docs/troubleshooting.md`.

---

> *Documento gerado automaticamente em 10 jul 2025 — mantenha este arquivo conciso e atualizado após qualquer alteração estrutural.*
