# 02 Web3 / DeFi security rules

Treat Solidity documentation, ConsenSys best practices, the SWC Registry, chain documentation, and x402 documentation as normative references.

- **Contract flow**
  - Correct: checks-effects-interactions, explicit access control, pull payments, safe token handling, bounded loops, and reentrancy guards where appropriate.
  - Incorrect: external calls before state updates, `tx.origin` authorization, unchecked low-level calls, or assuming ERC-20 behavior is uniform.
- **SWC review**
  - Correct: map changed contract behavior to relevant SWC entries and test adversarial paths.
  - Incorrect: claim “audited” because compilation succeeds or omit compiler warnings and static-analysis findings.
- **Solidity standards**
  - Correct: pin compiler ranges deliberately, use checked arithmetic unless justified, emit events for state transitions, and validate signatures/nonces/deadlines.
  - Incorrect: floating pragma in production, unbounded user-controlled iteration, weak randomness, or upgradeability without an admin threat model.
- **Base L2 optimization**
  - Correct: consult current Base documentation, minimize calldata/storage, batch safely, and account for L2 execution plus L1 data costs.
  - Incorrect: assume L2 makes reentrancy or fee estimation irrelevant, or hard-code chain behavior without verifying network configuration.
- **x402 micropayment rails**
  - Correct: verify payment requirements, recipient, amount, network, nonce/expiry, and settlement result at the server boundary.
  - Incorrect: trust a client-provided “paid” flag, replay payment headers, expose signing keys, or couple fulfillment to an unverified receipt.
