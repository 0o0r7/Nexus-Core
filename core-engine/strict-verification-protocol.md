# Strict verification protocol

No implementation is considered ready until the agent produces verification evidence. This protocol is a loop, not a one-time checklist.

## Required loop

1. **Define the boundary**: identify inputs, outputs, privileged operations, resource owners, and failure modes.
2. **Select authority**: cite current official references for every non-trivial API, protocol, security rule, and version-sensitive claim.
3. **Scan deprecations**: inspect release notes, official migration guides, and compiler/runtime warnings. Do not copy deprecated APIs or obsolete chain assumptions.
4. **Scan anti-patterns**:
   - Solidity/EVM: reentrancy, unchecked external calls, authorization gaps, unsafe arithmetic, oracle assumptions, denial of service, and missing checks-effects-interactions.
   - Browser/game: event-listener leaks, unbounded timers, retained DOM/canvas/GPU resources, runaway workers, blocking the main thread, and frame-time spikes.
   - Agents: unconstrained tools, prompt-injected instructions, stale state, non-idempotent retries, secret exposure, and payment hooks without verification.
5. **Validate dependencies**: confirm package provenance, version support, lockfile consistency, license, and whether a native alternative is sufficient.
6. **Run targeted checks**: lint, type-check, tests, static analysis, and `pre-flight-check.sh` appropriate to the changed surface.
7. **Inspect the diff**: verify least privilege, cleanup paths, error propagation, input validation, and no unrelated changes.
8. **Iterate** until findings are resolved or explicitly accepted with rationale.
9. **Publish evidence** before claiming completion: references, commands, results, remaining risks, and the exact route selected.

## Evidence format

```text
Route: <Web | Web3/DeFi | Game engineering | Agentic runtimes>
References: <official URLs and version/commit context>
Deprecation scan: <command/source and result>
Security scan: <findings and disposition>
Validation: <commands and pass/fail results>
Residual risk: <none, or explicit bounded risk>
```

A failed check is a blocking result. Never replace a failed check with a success-shaped fallback or omit the evidence because the change appears small.
