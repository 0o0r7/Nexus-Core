# 03 Web game performance

Use Robert Nystrom's *Game Programming Patterns*, Canvas/WebGL documentation, and Red Blob Games' math references as primary guidance.

- **Game loop**
  - Correct: separate update and render concerns, use elapsed time with a bounded timestep, and instrument frame time.
  - Incorrect: make simulation speed depend on render frequency, run an unbounded catch-up loop, or block the main thread with loading.
- **Object pool**
  - Correct: pool high-churn objects only after measurement, reset all state on acquire, and release deterministically.
  - Incorrect: pool everything, retain stale references, or use a pool that silently grows without a bound or metric.
- **State machine**
  - Correct: make legal transitions explicit, isolate state enter/exit cleanup, and test transition edges.
  - Incorrect: scatter boolean flags across update logic or leave subscriptions active after a state exit.
- **Canvas/WebGL**
  - Correct: batch draws, minimize state changes, use device-pixel-ratio consciously, release GPU resources, and handle context loss.
  - Incorrect: allocate per-frame, upload unchanged textures every frame, or assume a WebGL context is permanent.
- **Math and spatial logic**
  - Correct: use coordinate systems and algorithms suited to the problem, document invariants, and test boundary cases.
  - Incorrect: mix coordinate spaces, use floating-point equality for gameplay decisions, or copy pathfinding/hex-grid formulas without validating orientation and rounding.
