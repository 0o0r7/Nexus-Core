# 01 Web / MDN anti-patterns

Use MDN as the primary authority for Web Platform behavior.

- **DOM performance**
  - Correct: batch DOM reads and writes, use `DocumentFragment`, delegate stable events, and measure with browser tooling.
  - Incorrect: force synchronous layout in a loop, repeatedly query a live collection, or attach one listener per dynamic child.
- **Animation**
  - Correct: schedule visual updates with `requestAnimationFrame`, cancel on teardown, and derive motion from elapsed time.
  - Incorrect: animate with tight loops or unconstrained `setInterval`, or assume every display refresh is 60 Hz.
- **Workers**
  - Correct: move CPU-heavy work off the main thread, use structured-clone/transfer semantics intentionally, and terminate workers when ownership ends.
  - Incorrect: send huge copies unnecessarily, leave workers alive after navigation, or touch DOM APIs from a dedicated worker.
- **Web Crypto**
  - Correct: use `crypto.subtle`, secure contexts, CSPRNG output, authenticated encryption, and server-side secret management.
  - Incorrect: invent cryptography, use `Math.random()` for secrets, hard-code keys, or treat encoding/obfuscation as encryption.
- **Security boundaries**
  - Correct: explicit CSP/CORS, validate untrusted input, use secure cookies and HTTPS, and escape text by default.
  - Incorrect: wildcard credentialed CORS, unsafe HTML injection, or trusting client-side authorization.
