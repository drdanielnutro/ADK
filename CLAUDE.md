# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a documentation-only repository containing a Portuguese tutorial about ADK-Forge, a system for automatic generation of Google Agent Development Kit (ADK) applications. The project currently contains only tutorial documentation and no actual implementation code.

## Repository Structure

```
ADK/
└── tutorial.md - Complete Portuguese tutorial on ADK-Forge system
```

## Key Concepts from Documentation

The tutorial describes a meta-agent system that:
- Uses Google Agent Development Kit (ADK) to automate creation of ADK applications
- Receives project specifications in JSON or Mermaid format
- Generates complete, reviewed ADK code ready for deployment
- Implements a hybrid architecture combining LlmAgent and SequentialAgent

### Core Architecture Pattern

The system follows a pipeline approach:
1. **Orchestrator Agent** - Validates input and coordinates process
2. **Systems Architect Agent** - Analyzes requirements and creates technical plan
3. **Developer Agent** - Transforms plan into actual code
4. **Reviewer Agent** - Validates generated code against original plan

### Critical ADK Implementation Requirements

From the tutorial, key requirements for ADK projects:
- Main file must be `agent.py` containing `root_agent` variable
- `__init__.py` must import: `from . import agent`
- Custom tools must use `ToolContext` parameter
- LlmAgent uses `instruction` parameter (not `system_instruction`)
- SequentialAgent uses `sub_agents` parameter

## Development Context

This appears to be a learning/reference repository for understanding ADK-Forge concepts. If implementing the system described in the tutorial, follow the architectural patterns and code examples provided in `tutorial.md`.

## Language

The documentation is written in Portuguese and focuses on Brazilian Portuguese technical terminology.