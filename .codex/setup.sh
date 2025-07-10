#!/usr/bin/env bash
set -e  # aborta se algo falhar
set -x  # loga cada comando

# 1. Dependências Python / Node
pip install -r requirements.txt
npm install -g @openai/codex

# 2. Executa o gerador de código (apenas na 1ª vez)
if [ ! -f .codex/.bootstrap_done ]; then
  python run_manifest.py
  touch .codex/.bootstrap_done
else
  echo "Bootstrap já executado — pulando geração"
fi
