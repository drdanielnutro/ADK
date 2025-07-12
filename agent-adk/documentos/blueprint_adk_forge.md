# Blueprint Revisado – **ADK-Forge**

## 1. Executive Summary

ADK-Forge é um meta-agente capaz de transformar um esqueleto de projeto (JSON ou Mermaid) em uma aplicação ADK completa, pronta para revisão e deploy local. Um orquestrador central coordena quatro subagentes especializados: (1) Deep-Research Blueprint Builder, que gera o plano detalhado; (2) Fast-Audit / Clarifier, que responde dúvidas pontuais e revisa versões; (3) Code-Writer, que produz a base de código, manifests e testes; (4) Bug-Fix Assistant, que diagnostica e corrige erros. O blueprint descreve como adaptar os samples oficiais do repositório ADK, define contratos de dados via Pydantic, sugere uma árvore de diretórios modular e antecipa riscos de latência, limites de tokens e conflitos de dependências, indicando medidas de mitigação.

---

## 2. Arquitetura Geral

```text
+-------+
| User  |
+---+---+
    |
    v
+---+---------+
| Orchestrator|
|  (ADK-Forge)|
+---+---------+
  |  |  |  |
  |  |  |  +--> Bug-Fix Assistant (BF)
  |  |  +-----> Code-Writer (CW)
  |  +--------> Fast-Audit / Clarifier (FA)
  +-----------> Deep-Research Blueprint Builder (BR)
```

**Fluxo**

1. **BR**: gera blueprint detalhado da aplicação ADK.
2. **FA** (opcional): verifica itens específicos (versões, conformidade).
3. **CW**: converte blueprint em projeto ADK funcional.
4. **BF**: detecta falhas, aplica patches e reexecuta testes.

**Contratos**

* Todos os agentes usam `input_schema` e `output_schema` (Pydantic).
* Dados compartilhados via `session.state["blueprint"]`, `session.state["code_diff"]`, etc.

---

## 3. Subagentes, Origens e Ajustes

| Subagente                                | Sample de Origem         | Ajustes Principais                                                                                                                                                                                                                                                                    |
| ---------------------------------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Deep-Research Blueprint Builder (BR)** | `gemini-fullstack`       | • `agents/gemini_agent.py`: alterar prompt → “Gerar blueprint ADK detalhado”.<br>• `tools/web_search.py`: filtrar resultados para docs ADK.<br>• Output JSON validado com plano de agentes, ferramentas e config.                                                                     |
| **Fast-Audit / Clarifier (FA)**          | `llm-auditor`            | • `agents/llm_auditor.py`: aceitar segmentos de blueprint/código.<br>• Prompts focados em versão ADK, segurança e boas práticas.<br>• Retorno `{status, message, suggestions}`.                                                                                                       |
| **Bug-Fix Assistant (BF)**               | `software-bug-assistant` | • Adicionar `tools/file_system_bug_tools.py` para leitura/escrita no repo local.<br>• `agents/bug_assistant.py`: gerar patches aplicáveis com `unidiff`.<br>• Invocar `pytest` via FunctionTool para validar correções.                                                               |
| **Code-Writer (CW)**                     | — (novo)                 | • `agents/code_writer_agent.py`: lógica principal.<br>• `tools/file_system_tools.py`: CRUD de arquivos.<br>• `tools/code_formatter.py`: aplicar PEP8.<br>• `templates/*.jinja`: manifest, README, stubs de agente/ferramenta.<br>• Gera relatório JSON com lista de arquivos criados. |

---

### Exemplo de Contrato JSON

**Orchestrator → Code-Writer**

```json
{
  "blueprint": { ... },
  "target_path": "./generated_adk_app"
}
```

**Code-Writer → Orchestrator**

```json
{
  "status": "success",
  "output_path": "./generated_adk_app",
  "generated_files": [
    "main.py",
    "agents/greeting_agent.py",
    "tools/say_hello_tool.py"
  ]
}
```

---

## 4. Estrutura de Projeto

```text
adk_forge/
  orchestrator/
    main.py
    orchestrator_agent.py
    internal_apis/
  agents/
    deep_research/      # adaptado do gemini-fullstack
    fast_audit/         # adaptado do llm-auditor
    code_writer/        # novo
    bug_fix/            # adaptado do software-bug-assistant
  tools/
    file_system_tools.py
    code_formatter.py
  templates/
    manifest.yaml.jinja
    requirements.txt.jinja
    README.md.jinja
  tasks/
  configs/
    llm_config.yaml
    project_config.yaml
    .env
  requirements.txt
```

Configuração via YAML ou variáveis de ambiente permite alternar entre modelos locais (Ollama/vLLM) e provedores externos sem alterar código-fonte.

---

## 5. Riscos & Mitigações

| Risco                         | Mitigação                                                                                               |
| ----------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Latência em cadeia**        | Chamadas assíncronas + `ParallelAgent` em subtarefas.                                                   |
| **Limites de tokens/API**     | Resumos intermediários; modelos menores para tarefas simples; controle de taxa no orquestrador.         |
| **Conflitos de dependências** | venv dedicado por agente; `pyproject.toml` com versões fixas; refatorar bibliotecas comuns em `tools/`. |
| **Loops de delegação**        | Contador de iterações + estados de término explícitos.                                                  |
| **Perda de contexto**         | Passagem de dados via `session.state` + esquemas estritos.                                              |

---

## 6. Checklist Final

* [x] Resumo executivo ≤ 150 palavras
* [x] Diagrama ASCII em bloco preservado
* [x] Bullets de adaptação com caminhos reais
* [x] Nenhum link placeholder; apenas referências a docs/paths ADK
* [x] Detalhe das ferramentas internas do Code-Writer
* [x] Exemplo de contrato JSON Orchestrator ↔ Code-Writer
* [x] Estrutura de diretórios clara e modular

*Blueprint pronto para implementação.*
