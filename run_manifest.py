#!/usr/bin/env python3
"""
run_manifest.py — executor simples para o manifesto ADK-Forge.

• Percorre tasks em ordem, respeitando dependências
• Usa Codex CLI (--auto-edit / --create) para gerar arquivos
• Executa testStrategy de cada task e marca status=done no manifest.json
"""

from __future__ import annotations
import json, subprocess, shlex, textwrap
from pathlib import Path
from typing import Dict, Any, List

MANIFEST_FILE = Path("manifest.json")
CODEX_BIN = "codex"                     # altere se o binário tiver outro nome


def run(cmd: str, quiet: bool = False) -> None:
    """Executa um comando shell; lança exceção se returncode != 0."""
    proc = subprocess.run(cmd, shell=True, text=True,
                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if not quiet:
        print(proc.stdout.strip())
    if proc.returncode != 0:
        raise RuntimeError(f"\n❌  Falha: {cmd}\n{proc.stdout}")


def deps_ok(task: Dict[str, Any], status: Dict[str, str]) -> bool:
    return all(status.get(dep) == "done" for dep in task.get("dependencies", []))


def mark_done(task: Dict[str, Any], manifest: Dict[str, Any]) -> None:
    task["status"] = "done"
    MANIFEST_FILE.write_text(json.dumps(manifest, indent=2, ensure_ascii=False))


def exec_task(task: Dict[str, Any]) -> None:
    kind = task["kind"]
    match kind:
        case "file":
            path = Path(task["path"])
            path.parent.mkdir(parents=True, exist_ok=True)
            action = "--auto-edit" if path.exists() else "--create"
            prompt = textwrap.dedent(task["details"])
            cmd = f"{CODEX_BIN} {action} --file {path} --prompt {shlex.quote(prompt)}"
            print(f"📝  {task['id']} → {path}")
            run(cmd)

        case "dir":
            Path(task["path"]).mkdir(parents=True, exist_ok=True)
            print(f"📂  {task['id']} diretório criado: {task['path']}")

        case "shell":
            print(f"🔧  {task['id']} shell: {task['details']}")
            run(task["details"])

        case "meta":
            print(f"📋  {task['id']} meta — nenhuma ação direta")

        case _:
            raise ValueError(f"Tipo desconhecido (kind): {kind}")

    # Teste da própria tarefa
    if ts := task.get("testStrategy"):
        print(f"🔍  testStrategy: {ts}")
        run(ts, quiet=True)


def main() -> None:
    manifest = json.loads(MANIFEST_FILE.read_text())
    tasks = manifest["tasks"]

    # inclui subtarefas já planas dentro de tasks (caso existam)
    flat: List[Dict[str, Any]] = []
    for t in tasks:
        flat.extend(t.get("subtasks", []))
        flat.append(t)

    status_map = {t["id"]: t["status"] for t in flat}

    progress = True
    while progress:
        progress = False
        for task in flat:
            if task["status"] != "todo":
                continue
            if deps_ok(task, status_map):
                exec_task(task)
                status_map[task["id"]] = "done"
                mark_done(task, manifest)
                progress = True
        if not progress:
            break

    pending = [tid for tid, st in status_map.items() if st != "done"]
    if pending:
        raise SystemExit(f"⚠️  Ainda faltam tarefas: {pending}")

    # testes globais
    for t in manifest.get("tests", []):
        print(f"🔬  {t['id']}: {t['cmd']}")
        run(t["cmd"])


if __name__ == "__main__":
    main()
