# 04 Agentic runtimes

Verify current ElizaOS TypeScript specifications and payment-protocol documentation before implementation; adapters must not assume a framework version.

- **TypeScript contracts**
  - Correct: use explicit interfaces for actions, providers, evaluators, messages, and runtime state; validate external payloads at the boundary.
  - Incorrect: use broad `any`, rely on undocumented framework internals, or treat model text as a typed command without validation.
- **Autonomous state**
  - Correct: make state transitions explicit and observable, persist only necessary data, use idempotency keys, bound retries, and support cancellation.
  - Incorrect: allow hidden mutable global state, infinite retry loops, stale memory to override current authorization, or non-deterministic side effects without a journal.
- **Tool capabilities**
  - Correct: least-privilege tools, schemas, timeouts, audit logs, confirmation gates for irreversible actions, and prompt-injection-resistant separation of instructions from data.
  - Incorrect: expose arbitrary shell/network/wallet access, execute unvalidated model output, or leak secrets into prompts and traces.
- **Micropayment hooks**
  - Correct: verify x402/payment requirements and settlement server-side, bind payment to the exact resource/action, and make fulfillment idempotent.
  - Incorrect: let the agent self-attest payment, accept replayed receipts, or perform a paid side effect before authorization and settlement checks.
- **Lifecycle**
  - Correct: close streams, timers, subscriptions, workers, and provider connections on shutdown or cancellation.
  - Incorrect: leave background loops alive after a run, swallow tool errors, or report success after partial execution.
