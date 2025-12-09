# Nagada-Pulse Reference Implementation

**Status:** Active  
**Target Milestone:** v0.3  
**Purpose:** Provide a canonical working implementation of the Nagada-Pulse sync protocol.

---

## Overview

This reference implementation exists to demonstrate and validate the behavior defined in the Nagada-Pulse specification. It represents the baseline expected behavior of a compliant server and serves as the primary executable model of the protocol.

It is not intended to be the only implementation — rather, it ensures interoperability, consistent interpretation, and conformance across future SDKs, transports, and platforms.

---

## Goals

- Validate correctness of the protocol specification through executable behavior.
- Serve as the baseline environment for conformance and interoperability tests.
- Provide a clear implementation reference for developers implementing their own server or client.
- Enable experimentation and iteration during early protocol evolution.

---

## Non-Goals

- Production-grade scalability or cloud tuning.
- Serving as the only official implementation forever.
- Acting as a mandatory runtime or dependency for adopters.

The goal is **accuracy**, not optimization or feature expansion.

---

## Architecture

The reference implementation follows the structure defined in the specification:

- **Append-only event store**
- **Pending outbox processing**
- **Monotonic server event sequencing**
- **Systole → Diastole heartbeat sync**
- **Idempotency guarantees**
- **Version-aware wire format**

Optional extensions (WebSockets, CRDT, snapshotting) may be implemented later, behind experimental flags.

---

## Source Layout

    reference/
    └── http-server/
    ├── src/
    ├── tests/
    └── README.md


Future implementations may appear under:


    reference/
    └── websocket/
    └── dart-client/
    └── js-client/


---

## Compliance Expectations

The reference implementation **must always remain compliant** with the current stable portion of the specification.

If behavior conflicts with documentation:

> the specification prevails — unless clarified via review and updated consensus.

---

## Contributions

Contributions are welcome.  
Changes affecting protocol semantics must follow the governance and proposal process in:

    GOVERNANCE.md
    PROPOSAL_TEMPLATE.md


Bug fixes, docs improvements, and conformance refinements may be merged normally.

---

## Long-Term Direction

As Nagada evolves, this reference implementation may:

- remain the canonical model,
- become one of multiple official variants,
- or transition to a “compatibility and regression benchmark”.

Regardless of future direction, it will always remain:

> a faithful, open, and educational implementation of the Nagada-Pulse protocol.

---
