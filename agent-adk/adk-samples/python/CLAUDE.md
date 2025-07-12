# CodeViz Research Context

> **Note**: This file contains research context from CodeViz. Most recent contexts are at the bottom.

---

## Research Query

Investigate the "AcademicResearchAgent" component in detail. Focus your analysis on these key files:
1. agent.py (python/agents/academic-research/academic_research/agent.py)

Provide insights about the component's main responsibilities and functionality and how it integrates with other system components

*Session: 26050e3209dae7a1e2502e7a4ac8cab3 | Generated: 10/07/2025, 07:09:55*

### Analysis Summary

# AcademicResearchAgent Component Analysis

The **AcademicResearchAgent** is a high-level component designed to assist users with academic research tasks. Its primary responsibilities include analyzing seminal papers, providing research advice, locating relevant current papers, generating suggestions for new research directions, and accessing web resources for knowledge acquisition.

## Core Component: academic_coordinator

The central orchestrator of the **AcademicResearchAgent** is the **academic_coordinator** [agent.py](agents/academic-research/academic_research/agent.py:20). This component is implemented as an `LlmAgent`, indicating its reliance on a large language model for its core reasoning and task execution.

### Purpose
The **academic_coordinator** is responsible for:
*   Analyzing seminal papers provided by users.
*   Providing research advice.
*   Locating current papers relevant to a seminal paper.
*   Generating suggestions for new research directions.
*   Accessing web resources to acquire knowledge.

### Internal Parts and Configuration
The **academic_coordinator** is configured with:
*   **Name**: `academic_coordinator` [agent.py](agents/academic-research/academic_research/agent.py:21)
*   **Model**: It utilizes the `gemini-2.5-pro` model [agent.py](agents/academic-research/academic_research/agent.py:17,22).
*   **Description**: A detailed description outlining its capabilities [agent.py](agents/academic-research/academic_research/agent.py:23-28).
*   **Instruction**: It is guided by a specific prompt defined in `prompt.ACADEMIC_COORDINATOR_PROMPT` [agent.py](agents/academic-research/academic_research/agent.py:29). This prompt likely provides the LLM with its operational guidelines and context for academic research.
*   **Output Key**: `seminal_paper` [agent.py](agents/academic-research/academic_research/agent.py:30). This suggests that the agent's primary output or focus revolves around processing seminal papers.

### External Relationships and Integration

The **academic_coordinator** integrates with other system components through the use of `AgentTool`s. These tools extend its capabilities by allowing it to delegate specific sub-tasks to specialized agents.

The **academic_coordinator** is configured to use the following sub-agents as tools:
*   **academic_websearch_agent**: Integrated via `AgentTool(agent=academic_websearch_agent)` [agent.py](agents/academic-research/academic_research/agent.py:32). This sub-agent is likely responsible for performing web searches to acquire external knowledge, as indicated by its import path [agent.py](agents/academic-research/academic_research/agent.py:14).
*   **academic_newresearch_agent**: Integrated via `AgentTool(agent=academic_newresearch_agent)` [agent.py](agents/academic-research/academic_research/agent.py:33). This sub-agent probably handles tasks related to identifying and suggesting new research directions, as suggested by its import path [agent.py](agents/academic-research/academic_research/agent.py:13).

The `root_agent` for the entire **AcademicResearchAgent** component is set to the **academic_coordinator** [agent.py](agents/academic-research/academic_research/agent.py:36), meaning that the `academic_coordinator` serves as the entry point and primary control flow for all academic research-related queries.

