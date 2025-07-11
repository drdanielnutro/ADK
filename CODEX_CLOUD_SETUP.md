# Guia de Configuração do Codex Cloud para ADK-Forge

## 1. Preparação do Repositório

Certifique-se de que seu repositório contenha:
- ✅ `manifest.json` - Lista de tarefas do projeto
- ✅ `requirements.txt` - Dependências Python
- ✅ `AGENTS.md` - Contexto do projeto para o Codex
- ❌ ~~`run_manifest.py`~~ - Não necessário (é para CLI local)

## 2. Configuração no Codex Cloud

### 2.1 Setup Script
1. Acesse **Settings > Setup Script**
2. Cole o conteúdo do arquivo `codex_setup.sh`
3. Este script será executado automaticamente ao iniciar

### 2.2 Environment Variables
Acesse **Settings > Environment Variables** e configure:

```bash
# Credenciais Google Cloud (obrigatório)
GOOGLE_APPLICATION_CREDENTIALS=/workspace/service-account.json
GOOGLE_CLOUD_PROJECT=seu-projeto-id

# API Key do ADK (se aplicável)
ADK_API_KEY=sua-chave-api

# Python path (opcional, mas recomendado)
PYTHONPATH=/workspace
```

### 2.3 Internet Access
**Recomendação**: Manter **DESLIGADO** por padrão

Se precisar ativar, use allowlist restritiva:
- `pypi.org` - Para instalação de pacotes
- `googleapis.com` - Para APIs do Google Cloud
- Métodos permitidos: `GET`, `POST`

### 2.4 Workspace
- Ative **Shared Workspace** para manter progresso entre sessões
- Isso permitirá continuar de onde parou

## 3. Como Executar as Tarefas

### Passo 1: Inicialização
No Codex Cloud, use **Code Mode** com o prompt:
```
Leia o manifest.json e AGENTS.md. Execute a Task 1: 
Configure o ambiente e crie o esqueleto do projeto conforme especificado.
```

### Passo 2: Implementação Sequencial
Para cada tarefa subsequente:
```
Execute a Task [N] do manifest.json: [descrição da tarefa].
Siga as especificações no campo "details" e execute o testStrategy após implementar.
```

### Passo 3: Verificação
Após cada tarefa:
```
Verifique se o testStrategy da Task [N] passa com sucesso.
Se houver erros, corrija antes de prosseguir.
```

## 4. Prompts Recomendados por Tarefa

### Task 2 - File Tools:
```
Implemente adk_forge/tools/file_tools.py com as funções create_directory, 
write_file e read_file. Use ToolContext e implemente validação contra path traversal.
Teste com: python -m py_compile adk_forge/tools/file_tools.py
```

### Task 3-6 - Agentes:
```
Implemente o [NomeAgent] em adk_forge/agents/[arquivo].py 
conforme especificado na Task [N] do manifest.json.
Siga o formato e instruções detalhadas no campo "details".
```

### Task 7 - Pipeline:
```
Monte o ADKForgeGenerationPipeline em adk_forge/agents/__init__.py.
Use SequentialAgent com parâmetro sub_agents contendo architect, developer e reviewer.
Verifique que len(sub_agents) == 3.
```

### Task 8 - Sistema Principal:
```
Crie os arquivos finais do sistema:
- adk_forge/agent.py com a classe ADKForgeRunner
- adk_forge/__init__.py exportando root_agent
- main.py para execução via CLI
```

## 5. Dicas Importantes

### Segurança
- Sempre revise o código gerado antes de executar
- Mantenha internet access desligado quando possível
- Não commite credenciais no repositório

### Performance
- Divida tarefas complexas em múltiplas sessões
- Use o workspace compartilhado para manter estado
- Configure timeout adequado (10+ minutos)

### Debugging
- Se uma tarefa falhar, peça para ver os logs de erro
- Use o testStrategy para validar cada implementação
- Consulte docs/troubleshooting.md quando criado

## 6. Checklist de Verificação

Antes de começar:
- [ ] Repositório conectado via GitHub App
- [ ] MFA ativado na conta
- [ ] Setup script configurado
- [ ] Environment variables definidas
- [ ] AGENTS.md presente no repositório

Durante execução:
- [ ] Executar tarefas em ordem de dependência
- [ ] Testar cada componente após implementação
- [ ] Manter workspace para continuidade
- [ ] Revisar código antes de aceitar PRs

## 7. Solução de Problemas Comuns

### "Module not found"
- Verifique se o setup script rodou corretamente
- Confirme que requirements.txt está no repositório

### "Permission denied"
- Verifique configurações de segurança
- Confirme que não está tentando acessar paths externos

### "Timeout"
- Divida a tarefa em partes menores
- Aumente o timeout nas configurações

### "Import error"
- Verifique PYTHONPATH nas environment variables
- Confirme estrutura de diretórios