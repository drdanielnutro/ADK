# ADK-Forge Generation System

## Contexto do Projeto

Este projeto implementa um sistema de geração automatizada chamado ADK-Forge, baseado no Google ADK (Agent Development Kit) e Google Cloud AI Platform. O sistema utiliza múltiplos agentes especializados para gerar aplicações completas a partir de descrições de usuário.

## Arquitetura do Sistema

O ADK-Forge é composto por 4 agentes principais que trabalham em sequência:

1. **OrchestratorAgent**: Valida entrada e inicializa o ambiente
2. **SystemsArchitectAgent**: Gera plano de arquitetura em JSON
3. **DeveloperAgent**: Converte plano em código Python funcional
4. **ReviewerAgent**: Revisa código e gera relatório de qualidade

## Manifesto de Tarefas

O arquivo `manifest.json` contém 11 tarefas principais organizadas com dependências:

### Tarefas de Alta Prioridade:
- **Task 1**: Configuração do ambiente e esqueleto do projeto
- **Task 2**: Implementação de ferramentas de I/O seguras (file_tools.py)
- **Task 7**: Montagem do ADKForgeGenerationPipeline
- **Task 8**: Sistema principal e Runner CLI

### Tarefas de Média Prioridade:
- **Task 3**: OrchestratorAgent
- **Task 4**: SystemsArchitectAgent
- **Task 5**: DeveloperAgent
- **Task 6**: ReviewerAgent
- **Task 9**: Teste de validação automatizado

### Tarefas de Baixa Prioridade:
- **Task 10**: Dockerfile para deploy
- **Task 11**: Documentação de troubleshooting

## Dependências do Projeto

```
google-adk>=1.0.0
google-cloud-aiplatform>=1.60.0
pydantic>=2.0.0
python-dotenv>=1.0.0
pytest>=7.0.0
```

## Estrutura de Diretórios Esperada

```
adk_forge/
├── __init__.py
├── agent.py
├── tools/
│   ├── __init__.py
│   └── file_tools.py
└── agents/
    ├── __init__.py
    ├── orchestrator.py
    ├── architect.py
    ├── developer.py
    └── reviewer.py
```

## Instruções Importantes

### Segurança em file_tools.py
- Implementar validação contra path traversal
- Usar ToolContext para operações seguras
- Validar todos os caminhos antes de operações I/O

### Formato do Plano de Arquitetura
O SystemsArchitectAgent deve gerar JSON no formato:
```json
{
  "project_name": "string",
  "main_file": "string",
  "modules": [
    {
      "name": "string",
      "purpose": "string",
      "exports": ["string"]
    }
  ],
  "dependencies": ["string"]
}
```

### Pipeline de Agentes
O ADKForgeGenerationPipeline deve usar `SequentialAgent` com parâmetro `sub_agents` contendo os 3 agentes de geração (architect, developer, reviewer).

## Estratégias de Teste

Cada tarefa possui um `testStrategy` específico:
- Compilação Python: `python -m py_compile <arquivo>`
- Verificação de importação: `python -c "from ... import ..."`
- Execução de testes: `python test_forge.py`
- Build Docker: `docker build -t adk-forge:test .`

## Ordem de Execução Recomendada

1. Comece pela Task 1 (setup do ambiente)
2. Implemente Task 2 (file_tools) - base para outros agentes
3. Desenvolva os agentes na ordem: 3 → 4 → 5 → 6
4. Monte o pipeline (Task 7)
5. Crie o sistema principal (Task 8)
6. Execute testes e finalize com documentação

## Notas para o Codex Cloud

- Cada tarefa deve ser implementada respeitando as dependências
- Use o campo `details` de cada task como especificação
- Execute o `testStrategy` após implementar cada componente
- O sistema final deve permitir execução via CLI com `python -m adk_forge`