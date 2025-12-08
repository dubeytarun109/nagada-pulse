# CRDT Payload Support Proposal

**Status:** Proposed (Roadmap v0.8)  
**Author(s):** Nagada Community  
**Last Updated:** 2025-12-08

---

## Overview

This proposal defines support for **CRDT (Conflict-free Replicated Data Type)** event payloads within Nagada, enabling automatic conflict resolution at the data structure level rather than application level.

---

## Motivation

While Nagada is transport-agnostic and does not mandate conflict resolution strategies, many applications benefit from deterministic, commutative data structures (CRDTs) that automatically converge without human intervention.

Current state:
- Applications implement conflict resolution logic server-side
- Server returns compensating events
- Client must replay and reconcile

Proposed:
- CRDT-aware events carry sufficient information for client-side conflict detection
- Clients can apply CRDT merge semantics locally
- Reduces server-side conflict processing overhead

---

## Design

### Event Payload Extension

Add optional `crdtType` and `crdtOp` fields:

```json
{
  "clientEventId": "uuid-1",
  "type": "DOCUMENT_UPDATE",
  "entityId": "doc-123",
  "timestamp": "2025-12-08T10:00:00Z",
  "payload": {
    "text": "Hello"
  },
  "crdtType": "RGA",
  "crdtOp": {
    "type": "insert",
    "pos": 0,
    "char": "H",
    "timestamp": 1733660400000,
    "replicaId": "device-abc"
  }
}
```

### Supported CRDT Types

Phase 1 (v0.8):
- **LWW Register** – Last-write-wins for scalar values
- **G-Counter** – Growing counter (increment only)
- **PN-Counter** – Positive-negative counter (increment/decrement)
- **RGA** – Replicated Growable Array (for text and lists)

Phase 2 (v1.x):
- **LWW Map** – Map with per-field LWW
- **OR-Set** – Observed-Remove Set
- **OR-Map** – Combining ORSet with value resolution
- **Custom CRDTs** – Application-defined serialization

---

## Merge Semantics

### Client-Side Merge

When receiving a sync response with CRDT events:

```pseudocode
for each newServerEvent:
  if newServerEvent.crdtType:
    localValue = projection[newServerEvent.entityId]
    crdt = newServerEvent.crdtOp
    mergedValue = crdtMerge(localValue, crdt)
    projection[newServerEvent.entityId] = mergedValue
  else:
    // Standard event application
    applyEvent(projection, newServerEvent)
```

### Server-Side

Servers MAY:
- Store CRDT operations in event log
- Apply client-side merge logic to construct materialized views
- Detect conflicts using CRDT metadata (timestamps, replicaIds)

---

## Backward Compatibility

- `crdtType` and `crdtOp` are optional
- Non-CRDT events continue to work unchanged
- Servers without CRDT support treat them as regular events
- Clients may mix CRDT and non-CRDT events in same sync cycle

---

## Wire Format Changes

No breaking changes to core wire format:

```json
{
  "status": "OK",
  "acknowledgedEventIds": [...],
  "newServerEvents": [
    {
      "serverEventId": 501,
      "clientEventId": "uuid-1",
      "type": "DOCUMENT_UPDATE",
      "entityId": "doc-123",
      "timestamp": "2025-12-08T10:00:00Z",
      "payload": { "text": "Hello" },
      "crdtType": "RGA",
      "crdtOp": { ... }
    }
  ]
}
```

---

## Implementation Considerations

### ReplicaId Assignment

Each device needs a unique, stable replica ID for CRDT operations:
- Generated on first sync cycle
- Persisted locally alongside projection
- Sent with every client event

### Timestamp Ordering

CRDTs rely on causality:
- Client-side timestamps must be monotonically increasing per device
- Can use combination of `(deviceTimestamp, deviceId)` for tie-breaking
- Alternative: use server-assigned `serverEventId` in CRDT metadata

### Serialization

CRDT operations serialized as JSON for baseline compatibility:
- Standard types (G-Counter, LWW Register) have compact representations
- Complex types (RGA) may use delta encoding or binary notation
- Implementations may optimize with binary formats

---

## Testing

Conformance tests should verify:

- [ ] LWW values converge correctly across devices
- [ ] Counters produce identical totals regardless of event order
- [ ] RGA (text/list) converges to expected sequence
- [ ] Conflict detection works for concurrent edits
- [ ] CRDT merge doesn't affect non-CRDT events
- [ ] ReplicaId consistency across sync cycles

---

## Example: Collaborative Document

**Scenario:** Two devices editing a text document simultaneously.

**Device A (timestamp 1000):**
```json
{
  "clientEventId": "a1",
  "type": "TEXT_INSERT",
  "entityId": "doc-1",
  "payload": { "text": "H" },
  "crdtType": "RGA",
  "crdtOp": { "op": "insert", "pos": 0, "char": "H", "replicaId": "a", "ts": 1000 }
}
```

**Device B (timestamp 1000):**
```json
{
  "clientEventId": "b1",
  "type": "TEXT_INSERT",
  "entityId": "doc-1",
  "payload": { "text": "E" },
  "crdtType": "RGA",
  "crdtOp": { "op": "insert", "pos": 0, "char": "E", "replicaId": "b", "ts": 1000 }
}
```

**Convergence:**
- Without CRDT: Conflict, needs resolution
- With RGA: Both clients converge to "EH" (deterministic order by replicaId, then timestamp)

---

## Non-Goals

- CRDT support will **not** replace standard event semantics
- Clients are **not required** to implement CRDT logic to remain protocol-compliant
- CRDT behavior will **not modify sync ordering** — global ordering still depends on `serverEventId`
- CRDT payloads will **not define a universal application schema**

---

## Execution Responsibility

| Layer | Responsibility |
|-------|--------------|
| Client | Apply CRDT operations, merge locally, update projection |
| Server | Store raw CRDT ops as events; MAY build CRDT-aware projections |
| Wire Format | Transport only — not CRDT-aware |

### CRDT Operation Properties

CRDT operations MUST be:

- **Idempotent** – Safe to apply multiple times
- **Commutative** – Order of arrival must not change final result
- **Associative** – Batching operations must still converge

These ensure deterministic rebuild during event replay or snapshot restore.

### Client-Server Negotiation

Clients MAY advertise supported CRDT types via a future `capabilities` field.

Servers MAY use this to decide whether to:

- Send raw CRDT ops  
- Send merged state  
- Downgrade to non-CRDT fallback

### Summary

CRDT payload support enables advanced collaboration and offline concurrency use cases without changing the core Nagada protocol. It remains optional, backward-compatible, and layered purely as event metadata rather than protocol semantics — allowing the ecosystem to scale from simple CRUD sync to real-time multiplayer collaboration when desired.

---

## Future Research

- Hybrid approaches: CRDT + application-level policies
- Performance optimization for large CRDT structures
- Streaming CRDT updates for real-time collaboration
- Blockchain-based CRDT verification

