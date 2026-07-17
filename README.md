# Customer Support & Intelligent Escalation Multi-Agent System

A production-grade, multi-agent AI system that processes customer support
tickets using a **fan-out / fan-in** orchestration pattern, retrieval-augmented
generation (RAG), a reflection (self-critique) loop, tool-calling, memory,
guardrails, structured observability, and an evaluation harness.

Built with **Python + Groq (LLM) + ChromaDB (vector store) + a custom
orchestrator** (no LangGraph dependency â€” orchestration logic is implemented
directly for full transparency and control).

---

## 1. Architecture Overview

### 1.1 How the system works, end to end

```
                         â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
                         â”‚   Ticket comes in         â”‚
                         â”‚  (customer_id, message,   â”‚
                         â”‚   optional order_id)      â”‚
                         â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                                      â”‚
                         â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
                         â”‚   INPUT GUARDRAILS         â”‚
                         â”‚  - validate_input()        â”‚
                         â”‚  - PII scrub (scrub_pii)   â”‚
                         â”‚  â†’ blocked? â†’ escalate      â”‚
                         â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                                      â”‚
         â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
         â”‚                    STAGE 1: FAN-OUT (parallel)            â”‚
         â”‚  â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”        â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”   â”‚
         â”‚  â”‚   Triage Agent      â”‚        â”‚  Knowledge Agent     â”‚   â”‚
         â”‚  â”‚  category/urgency/  â”‚        â”‚  RAG: KB + similar   â”‚   â”‚
         â”‚  â”‚  risk classificationâ”‚        â”‚  past tickets        â”‚   â”‚
         â”‚  â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜        â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜   â”‚
         â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                        â”‚                                 â”‚
                        â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                                         â”‚  STAGE 2: FAN-IN
                              â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
                              â”‚   Resolution Agent      â”‚
                              â”‚  generates response +   â”‚
                              â”‚  calls tools (refund,    â”‚
                              â”‚  order status, account)  â”‚
                              â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                                         â”‚
                          â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
                          â”‚        Critic Agent            â”‚â—„â”€â”€â”
                          â”‚  reviews accuracy, policy,      â”‚   â”‚ reflection
                          â”‚  tone â†’ approve / reject         â”‚   â”‚ loop
                          â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜   â”‚ (max N
                                 approved?â”‚ no                â”‚  retries)
                                         â”‚ yes    â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                          â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
                          â”‚      OUTPUT GUARDRAILS          â”‚
                          â”‚   PII scrub on outbound text    â”‚
                          â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                                         â”‚
                              â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
                              â”‚      Email Agent        â”‚
                              â”‚  customer reply and/or  â”‚
                              â”‚  internal escalation     â”‚
                              â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                                         â”‚
                              â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
                              â”‚   Long-Term Memory       â”‚
                              â”‚ (resolved ticket written â”‚
                              â”‚  back for future RAG)    â”‚
                              â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

The **Supervisor** (`orchestrator/supervisor.py`) owns this entire flow. No
agent ever calls another agent directly â€” every hand-off, retry, and routing
decision is made centrally, which keeps the control flow auditable and makes
it easy to add new agents or change the routing policy without touching
agent internals.

### 1.2 Why fan-out / fan-in (not a linear chain)

A linear pipeline (`triage â†’ knowledge â†’ resolution â†’ critic â†’ email`) would
force the Knowledge Agent to wait on the Triage Agent even though **neither
depends on the other's output** â€” both only need the raw customer message.
Running them concurrently via `ThreadPoolExecutor` is a genuine latency win,
not just a stylistic choice.

More importantly, fan-out/fan-in is the right *shape* for this problem:
several independent specialists gather evidence in parallel, and a
downstream agent (Resolution) makes a decision by combining (fanning in)
all of that evidence â€” a pattern used in real distributed reasoning and
multi-agent systems, rather than a single agent trying to do everything in
one pass.

The **reflection loop** (Critic â†’ Resolution â†’ Critic, bounded by
`MAX_CRITIC_RETRIES`) is a second, smaller fan-in cycle: the Critic's
rejection feedback is fed back into the Resolution Agent's next attempt,
and if the ticket still isn't approved after the retry budget is exhausted,
the Supervisor force-escalates to a human rather than looping forever or
silently shipping a rejected response.

### 1.3 Resilience / offline-mode design

Two subsystems have automatic, logged fallbacks so the system is always
runnable, even without network access or API credentials:

- **LLM layer** (`utils/llm_client.py`): if `GROQ_API_KEY` is unset (or the
  Groq API is unreachable after retries), the client transparently falls
  back to a deterministic, rule-based **offline mock responder** so the
  full pipeline â€” orchestration, tool calls, guardrails, memory, evals â€”
  remains exercisable end-to-end. This is logged loudly
  (`Running in OFFLINE mock-LLM mode`), never silent.
- **Vector store** (`memory/vector_store.py`): if ChromaDB (and its
  embedding model download) can't be initialized, the system falls back to
  a dependency-free, pure-Python bag-of-words cosine-similarity store with
  the exact same interface, so RAG retrieval still works.

With a real `GROQ_API_KEY` set, both subsystems use the real Groq LLM and
ChromaDB's embedding-based semantic search, giving substantially higher
classification/response quality than the offline heuristics.

---

## 2. Directory Breakdown

```
project-root/
â”œâ”€â”€ agents/          Five specialized agents, each a pure function of TicketState
â”œâ”€â”€ orchestrator/     Supervisor (fan-out/fan-in control flow) + shared TicketState
â”œâ”€â”€ tools/             Mock backend APIs + email delivery tool
â”œâ”€â”€ memory/            Short-term (in-process) and long-term (vector-indexed) memory
â”œâ”€â”€ guardrails/        Input/output validation, PII detection & redaction, pre-action safety checks
â”œâ”€â”€ evals/             Sample tickets + evaluation harness/metrics
â”œâ”€â”€ utils/              LLM client (with offline fallback) + structured logger
â”œâ”€â”€ config/             Settings (env-driven) + static knowledge base documents
â”œâ”€â”€ main.py            CLI entrypoint (single ticket or --eval)
â”œâ”€â”€ demo.py             Runs 7 curated scenarios showcasing every major behavior
â”œâ”€â”€ api.py               FastAPI server + browser UI (static/index.html) for live testing
â”œâ”€â”€ static/              Browser-based UI served by api.py
â”œâ”€â”€ requirements.txt
â”œâ”€â”€ .env.example
â””â”€â”€ README.md          (this file)
```

---

## 3. File-by-File Explanation

### `config/`
- **`settings.py`** â€” Loads `.env` and exposes every tunable as a typed
  constant: Groq model/params, Chroma persistence path, critic retry
  budget & pass threshold, refund auto-approval limit, escalation email
  address, SMTP settings, log level. `OFFLINE_MODE` is derived here from
  whether `GROQ_API_KEY` is set.
- **`knowledge_base/*.txt`** â€” Five static policy documents (refunds,
  shipping, accounts, technical support, billing) ingested into the
  Knowledge Agent's vector store on first run.

### `orchestrator/`
- **`state.py`** â€” `TicketState`, the single dataclass passed between every
  agent. It's the system's working/short-term memory for one ticket, and
  is fully serializable (`to_dict()`) for logging/API responses.
- **`supervisor.py`** â€” The orchestrator. Implements `process_ticket()`:
  runs input guardrails â†’ fans out Triage + Knowledge in parallel via
  `ThreadPoolExecutor` â†’ fans in to Resolution â†’ runs the bounded
  Critic/reflection loop â†’ runs output guardrails â†’ hands off to the
  Email Agent. Also handles graceful degradation if one fan-out agent
  fails (fills safe defaults so the pipeline still completes).

### `agents/`
- **`triage_agent.py`** â€” Classifies `category` (billing/technical/refund/
  account/shipping/general), `urgency` (low/medium/high), and `risk_level`
  (low/medium/high) via a JSON-mode LLM call.
- **`knowledge_agent.py`** â€” Pure RAG: queries the static knowledge-base
  vector store and the long-term ticket-history vector store for the
  current message; attaches both result sets to `TicketState`.
- **`resolution_agent.py`** â€” The fan-in consumer. Builds a single prompt
  combining triage output + retrieved knowledge + similar past tickets
  (+ critic feedback on retries), asks the LLM for a response plan, then
  actually **executes** the recommended tool calls (`check_order_status`,
  `issue_refund`, `update_account`). If any executed action fails or
  requires manual approval (e.g. a refund over the auto-approval limit),
  it overrides the response and forces human-review escalation rather
  than describing an action that didn't actually happen.
- **`critic_agent.py`** â€” First runs a fast, deterministic guardrail check
  (`validate_output`), then an LLM-based review for accuracy (grounded in
  the retrieved KB), policy compliance, and tone. Returns `approved`,
  a `score`, `issues`, and `feedback` used to drive the reflection loop.
- **`email_agent.py`** â€” Formats and "sends" (mock or real SMTP) the final
  customer reply, and separately sends an internal escalation email for
  any ticket that is blocked, requires human review, or failed critic
  review after all retries. Writes successfully auto-resolved tickets
  back into long-term memory.

### `tools/`
- **`db.py`** â€” Lightweight SQLite-backed storage for orders, accounts,
  and issued refunds (`support_system.db`, created and seeded
  automatically on first run). Replaced the earlier in-memory Python
  dicts so backend data now persists across runs and can be inspected
  with any SQLite browser without touching code.
- **`mock_apis.py`** â€” `check_order_status`, `issue_refund`,
  `update_account`, backed by `tools/db.py`. `issue_refund` is wired
  through two safety layers before doing anything: the
  `check_refund_action_safety` guardrail (order verified, amount
  positive, under the auto-approval limit), and a business-logic check
  that blocks refunding an order that's already `cancelled` or
  `refunded` (forces `requires_human_approval` instead of silently
  double-refunding).
- **`email_tool.py`** â€” `send_email()`. Mock mode (default) appends to
  `logs/sent_emails.jsonl`; SMTP mode sends a real email and falls back to
  mock delivery if SMTP isn't configured or fails, so email delivery
  issues never crash the pipeline.

### `memory/`
- **`short_term.py`** â€” Thread-safe in-process store of active/recent
  `TicketState` objects (working memory for the duration of the process).
- **`vector_store.py`** â€” `ChromaVectorStore` (primary) and
  `SimpleFallbackVectorStore` (dependency-free offline fallback), behind a
  common interface (`add`, `query`, `count`).
- **`long_term.py`** â€” Two persistent collections: the static knowledge
  base (ingested once) and resolved-ticket history (written after every
  successfully auto-resolved ticket). Both are queried by the Knowledge
  Agent.

### `guardrails/`
- **`pii.py`** â€” Regex-based detection/redaction of emails, phone numbers,
  credit card numbers, and SSNs. Applied to both inbound messages and
  outbound responses.
- **`validators.py`** â€” `validate_input` (length/emptiness/high-risk
  keyword checks), `validate_output` (non-empty, not absurdly long, no
  AI-disclosure meta-commentary), and `check_refund_action_safety`
  (order-verification + auto-approval dollar limit) â€” the pre-action
  safety check specifically for the highest-risk tool call.

### `evals/`
- **`test_tickets.json`** â€” Six sample tickets with expected category,
  minimum urgency, and (for one) an expected human-review routing outcome.
- **`eval_runner.py`** â€” Runs every sample ticket through the real
  `Supervisor`, then computes routing accuracy, urgency accuracy,
  completeness rate, human-review routing accuracy, critic pass rate, and
  average latency. Writes `evals/eval_results.json` and prints a table.

### `utils/`
- **`llm_client.py`** â€” The only place that talks to Groq. Centralizes
  retries, JSON-mode prompting, and the offline mock fallback described in
  Â§1.3.
- **`logger.py`** â€” Structured JSON logging to `logs/system.log` (plus
  human-readable console output), and `agent_span()` â€” a context manager
  every agent uses to time itself and attach a structured trace entry
  (`agent`, `status`, `duration_ms`, `output`) to `TicketState.trace`.

### Root
- **`main.py`** â€” CLI: run one ticket (`--message`, `--customer`,
  `--order`) or the eval suite (`--eval`); `--json` dumps the full ticket
  state.
- **`demo.py`** â€” Seven scenarios in one script: a normal auto-resolved
  refund, a high-risk security ticket that escalates, an over-limit
  refund that gets blocked by the guardrail and escalates, a PII-bearing
  message that gets redacted, an invalid empty ticket that gets blocked
  outright, a refund attempt on a cancelled order, and a refund attempt
  on an already-refunded order (both blocked by the business-logic
  guardrail in `tools/mock_apis.py`). Prints the full agent trace for each.
- **`api.py`** â€” FastAPI server exposing the same `Supervisor` over HTTP
  (`POST /tickets`, `GET /tickets/{id}`, `GET /tickets`, `GET /health`),
  and serves a small browser UI (`static/index.html`) at `/` for
  submitting tickets and viewing results/traces live without the CLI.

---

## 4. Execution Flow (step by step)

1. `Supervisor.process_ticket()` creates a `TicketState` and stores it in
   short-term memory.
2. **Input guardrails** run: PII is scrubbed from the inbound message;
   `validate_input` checks length/emptiness/high-risk keywords. A failing
   ticket is marked `blocked`, an escalation email is sent, and the
   pipeline stops there.
3. **Fan-out**: Triage Agent and Knowledge Agent run concurrently in a
   `ThreadPoolExecutor`. Triage writes `category/urgency/risk_level`;
   Knowledge writes `kb_results/similar_past_tickets`. If either fails,
   the Supervisor fills safe defaults and continues rather than crashing.
4. **Fan-in**: Resolution Agent combines both outputs into one prompt,
   gets a response + action plan from the LLM, and executes the
   recommended tools. A failed/blocked tool call forces
   `requires_human_review = True` and rewrites the customer-facing text.
5. **Reflection loop**: Critic Agent reviews the resolution. If rejected
   and retries remain and the ticket isn't already flagged for human
   review, the Supervisor reruns Resolution (now with the critic's
   feedback embedded in its prompt) and Critic again, up to
   `MAX_CRITIC_RETRIES` times. Exhausting retries without approval forces
   escalation.
6. **Output guardrails**: the approved resolution text is scrubbed for PII
   before delivery.
7. **Delivery**: Email Agent sends the customer reply (or an
   acknowledgement, if escalated) and/or an internal escalation email.
   Successfully auto-resolved tickets are written into long-term memory.
8. Final `TicketState` (including the full per-agent trace) is returned
   and stored back in short-term memory.

---

## 5. How to Run

### 5.1 Setup

```bash
# from the project root
python -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate

pip install -r requirements.txt

cp .env.example .env
# Edit .env and set GROQ_API_KEY for full LLM-powered operation.
# Leaving it blank runs the system in offline mock-LLM mode (see Â§1.3) --
# useful for quickly verifying the pipeline works before wiring up a key.
```

### 5.2 Run a single ticket

```bash
python main.py
# or with your own ticket:
python main.py --message "My order never arrived, order ORD-1002" --customer CUST-002 --order ORD-1002 --json
```

### 5.3 Run the full demo (7 scenarios)

```bash
python demo.py
```

This showcases: a normal auto-resolved refund with real tool execution, a
high-risk ticket that correctly escalates instead of auto-resolving, an
over-limit refund blocked by the guardrail, PII redaction, a blocked
invalid ticket, a refund attempt on a **cancelled** order (blocked by a
business-logic guardrail), and a refund attempt on an order that's
**already been refunded** (blocked to prevent a double refund) â€” printing
the full per-agent trace for each.

### 5.3.1 Run the web UI + API server

```bash
uvicorn api:app --reload --port 8000
```

Then open `http://127.0.0.1:8000` in a browser for a simple form where you
can submit a ticket, pick a customer/order, and watch the category,
urgency, risk, final response, and full per-agent trace render live â€”
backed by the exact same `Supervisor` used by `main.py` and `demo.py`.
Interactive API docs (Swagger) are available at
`http://127.0.0.1:8000/docs`.

### 5.4 Run the evaluation suite

```bash
python main.py --eval
# or directly:
python evals/eval_runner.py
```

Prints a metrics summary (routing accuracy, urgency accuracy, completeness,
human-review routing accuracy, critic pass rate, average latency) and a
per-ticket results table, and writes `evals/eval_results.json`.

> **Note on offline-mode eval scores:** the offline mock LLM uses simple
> keyword heuristics, not real language understanding, so routing accuracy
> in offline mode is intentionally imperfect (it's there to prove the
> harness and pipeline work, not to benchmark model quality). Set a real
> `GROQ_API_KEY` for representative accuracy numbers.

### 5.5 Inspect logs and sent emails

```bash
cat logs/system.log          # structured JSON logs, one event per line
cat logs/sent_emails.jsonl   # every email "sent" during mock-mode runs
```

---

## 6. Key Design Decisions (for reviewers)

- **Custom orchestrator over LangGraph**: keeps the fan-out/fan-in and
  reflection-loop control flow fully explicit and dependency-light, and
  makes the retry/escalation logic easy to audit in one file
  (`orchestrator/supervisor.py`).
- **Centralized guardrails, not agent-embedded**: input/output validation
  and PII scrubbing live in the Supervisor, not inside individual agents,
  so policy changes don't require touching agent prompts.
- **Tool execution lives in the Resolution Agent, not the LLM**: the LLM
  recommends actions; Python code executes them and is the sole source of
  truth for whether something actually happened â€” the LLM's text can't
  silently claim an action succeeded when the guardrail blocked it.
- **Business-logic guardrails, not just policy guardrails**: beyond the
  dollar-limit check, `issue_refund` also checks real order state (via
  `tools/db.py`) and refuses to refund an order that's cancelled or
  already refunded â€” a category of bug (double refunds) that a
  purely LLM-based check could miss if the model wasn't explicitly
  reminded of an order's current status.
- **Everything degrades gracefully and loudly**: missing API key, missing
  vector DB, missing SMTP config, or a failed fan-out agent all have
  logged fallbacks rather than hard crashes, while still being visible in
  `logs/system.log`.

