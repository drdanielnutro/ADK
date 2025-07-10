#!/usr/bin/env python3
"""
run_manifest.py – executor simples para manifesto ADK-Forge.

• Executa tasks em ordem, respeitando dependências.
• Usa Codex CLI (--auto-edit) para gerar/editar arquivos.
• Atualiza status no próprio JSON.
"""
from __future__ import annotations
import json, subprocess, shlex, textwrap
from pathlib import Path
from typing import Dict, Any, List

MANIFEST_FILE = Path("manifest.json")
CODEX_BIN = "codex"           # altere se estiver em outro path


def run(cmd: str, cwd: Path | None = None, quiet=False) -> subprocess.CompletedProcess:
    """Executa comando shell; lança exceção se returncode != 0."""
    proc = subprocess.run(cmd, shell=True, cwd=cwd, text=True,
                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if not quiet:
        print(proc.stdout.strip())
    if proc.returncode != 0:
        raise RuntimeError(f"❌  Comando falhou: {cmd}\n{proc.stdout}")
    return proc


def dependencies_done(task: Dict[str, Any], status_map: Dict[str, str]) -> bool:
    return all(status_map.get(dep) == "done" for dep in task.get("dependencies", []))


def mark_done(task: Dict[str, Any], manifest: Dict[str, Any]) -> None:
    task["status"] = "done"
    # grava manifest atualizado
    MANIFEST_FILE.write_text(json.dumps(manifest, indent=2, ensure_ascii=False))


def execute_task(task: Dict[str, Any]) -> None:
    kind = task.get("kind")
    if kind == "file":
        file_path = Path(task["path"])
        file_path.parent.mkdir(parents=True, exist_ok=True)
        action = "--auto-edit" if file_path.exists() else "--create"
        prompt = textwrap.dedent(task["details"])
        cmd = f"{CODEX_BIN} {action} --file {file_path} --prompt {shlex.quote(prompt)}"
        print(f"📝  {task['id']} ➜ {file_path}")
        run(cmd)
    elif kind == "dir":
        Path(task["path"]).mkdir(parents=True, exist_ok=True)
        print(f"📂  {task['id']} diretório criado: {task['path']}")
    elif kind == "shell":
        print(f\"🔧  {task['id']} comando shell: {task['details']}\")
        run(task["details"])
    elif kind == "meta":
        # meta só coordena subtarefas; nada a fazer aqui
        print(f\"📋  {task['id']} meta – nenhuma ação direta.\")
    else:
        raise ValueError(f\"Kind desconhecido: {kind}\")

    # rodar teste da task, se existir
    if ts := task.get("testStrategy"):
        print(f\"🔍  testStrategy: {ts}\")
        run(ts, quiet=True)


def main():
    manifest: Dict[str, Any] = json.loads(MANIFEST_FILE.read_text())
    tasks: List[Dict[str, Any]] = manifest["tasks"]
    status_map = {t["id"]: t["status"] for t in tasks}

    # lista linear incluindo subtarefas (meta mantém subtasks já no JSON)
    flat_tasks: List[Dict[str, Any]] = []
    for t in tasks:
        if t.get("subtasks"):
            flat_tasks.extend(t["subtasks"])
        flat_tasks.append(t)

    # loop até tudo done
    progress = True
    while progress:
        progress = False
        for task in flat_tasks:
            if task["status"] != "todo":
                continue
            if dependencies_done(task, status_map):
                execute_task(task)
                status_map[task["id"]] = "done"
                mark_done(task, manifest)
                progress = True
        if not progress:
            break  # nenhuma task pôde rodar => possível dead-lock

    remaining = [tid for tid, st in status_map.items() if st != "done"]
    if remaining:
        print(f\"⚠️  Tarefas pendentes: {remaining}\")
    else:
        print(\"✅  Todas as tasks concluídas!  Rodando testes globais...")
        for test in manifest.get("tests", []):
            print(f\"🔬  {test['id']}: {test['cmd']}\")
            run(test["cmd"])


if __name__ == \"__main__\":  # pragma: no cover
    main()
