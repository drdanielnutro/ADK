# Teste do Voice Mode - Guia Rápido

## Instalação Concluída ✅

O Voice Mode foi instalado com sucesso globalmente no seu sistema!

## Como Testar

1. **Inicie o Claude Code em qualquer diretório:**
   ```bash
   claude
   ```

2. **Ative o Voice Mode dizendo (em inglês):**
   ```
   "Let's have a voice conversation"
   ```

3. **O Voice Mode deve responder e você poderá:**
   - Falar comandos de programação
   - Pedir para editar código
   - Fazer perguntas sobre o projeto
   - Dar instruções em português após a ativação

## Comandos Úteis de Voz

- "Help me debug this error" (ajude-me a debugar este erro)
- "Write a function that..." (escreva uma função que...)
- "Explain this code" (explique este código)
- "Refactor this method" (refatore este método)

## Troubleshooting

Se o Voice Mode não ativar:

1. **Verifique se a API Key está configurada:**
   ```bash
   echo $OPENAI_API_KEY
   ```

2. **Verifique permissões de microfone (macOS):**
   - Configurações > Privacidade e Segurança > Microfone
   - Certifique-se que o Terminal tem permissão

3. **Teste em um novo terminal:**
   - Abra um novo terminal
   - Execute `claude` novamente

## Notas Importantes

- A API Key já está salva no seu `~/.zshrc`
- O Voice Mode funcionará em qualquer projeto
- Não precisa reinstalar para cada projeto
- Disponível sempre que usar `claude`

## Próximos Passos

Experimente o Voice Mode no seu projeto ADK atual para:
- Refatorar agentes
- Escrever novos prompts
- Debugar código
- Fazer perguntas sobre a estrutura do projeto

Boa sorte com o Voice Mode! 🎤