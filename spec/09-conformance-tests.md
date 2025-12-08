 # Conformance Tests

This document defines the required test scenarios for verifying protocol correctness and interoperability of both client and server implementations.

---

## 1. Purpose

The conformance test suite ensures:

- Correct synchronization behavior
- Idempotency guarantees
- Projection rebuild integrity
- Compatibility across platforms

---

## 2. Testing Requirements

Implementations MUST pass all **required** scenarios.  
Optional scenarios test additional behaviors but are not mandatory.

---

## 3. Test Categories

| Category | Required | Description |
|----------|----------|-------------|
| Event submission | ✔ | Client events are accepted, stored, and acknowledged. |
| Duplicate event handling | ✔ | Retries must not create duplicate server events. |
| Ordering correctness | ✔ | Events applied in ascending `serverEventId`. |
| Projection rebuild | ✔ | Full rebuild reproduces identical state. |
| Retry resiliency | ✔ | Sync resumes after transient failures. |
| Offset tracking | ✔ | Events after offset are delivered exactly once. |
| Conflict handling output | ✔ | Server emits resolution events if policy applies. |
| Heartbeat pacing | Optional | Client obeys server pacing hints. |

---

## 4. Core Test Scenarios

### Scenario 1 — Basic Sync

1. Client submits 1 event.
2. Server appends and returns 1 ordered event.
3. Client removes from outbox and updates projection.

### Scenario 2 — Retry Idempotency

1. Client submits an event.
2. Network failure prevents acknowledgment.
3. Client retries same event.
4. Server returns one server event and not two.

### Scenario 3 — Multi-Device Ordering

Two devices submit events out of order; server ordering MUST establish causality.

### Scenario 4 — Projection Rebuild

1. Delete projection.
2. Replay all events.
3. Result MUST match live state.

---

## 5. Acceptance Criteria

A conformant implementation MUST:

- Pass all required tests.
- Demonstrate deterministic projections after replay.
- Preserve history without mutation.

---

## 6. Reporting Format

Test harness output MUST include:

```json
{
  "implementation": "nagada-java-server",
  "protocolVersion": "0.1.0",
  "results": {
    "required": { "passed": 8, "failed": 0 },
    "optional": { "passed": 3, "failed": 1 }
  }
}
```

## 7. Extensibility

Future versions MAY add:

randomized fuzz tests

timing simulation under packet loss

CRDT or advanced merge cases