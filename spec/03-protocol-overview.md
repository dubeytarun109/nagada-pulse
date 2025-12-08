# Protocol Overview

Nagada defines a synchronization process based on incremental event exchange between Clients and a Server. The protocol ensures that all participating devices eventually converge to the same ordered event history.

---

## 1. System Model

Nagada assumes:

- Multiple independent Clients may modify data concurrently.
- Network connectivity may be unavailable, intermittent, delayed, or reordered.
- The Server is responsible for organizing Events into a canonical order.

Clients maintain state locally and synchronize asynchronously.

---

## 2. Sync Rhythm Model

Nagada organizes synchronization into a repeating two-phase cycle:

| Phase | Direction | Purpose |
|--------|-----------|---------|
| **Systole** | Client → Server | Submit pending Client Events and report last known server offset. |
| **Diastole** | Server → Client | Acknowledge submitted events and deliver new Server Events. |

This exchange enables Clients to converge to the global state while retaining autonomy during offline periods.

---

## 3. Ordering and Event Stream

The Server assigns a sequential `serverEventId` to each accepted Event. The global stream MUST maintain:

- Strict monotonic ordering
- No gaps except reserved or system-defined ones
- Immutable event history

Clients never attempt to establish global ordering.

---

## 4. State Held by the Client

A compliant Client maintains:

| Component | Description |
|----------|-------------|
| **Pending Outbox** | Local queue of unacknowledged Client Events. |
| **Local Projection** | Materialized state derived from applying ordered Server Events. |
| **Last Known Server Event ID** | Numeric bookmark indicating sync progress. |

No additional persistent global state is required.

---

## 5. Transport Layer

Nagada does not mandate a specific transport but defines expectations:

- Reliable delivery is *not* assumed; messages may be retried.
- HTTP POST is the baseline transport.
- Optional transports MAY include WebSockets, SSE, or gRPC.

Transport negotiation and protocol versioning will be covered in later documents.

---

## 6. Retry and Idempotency

Clients MAY repeat requests when:

- A response is not received
- A network error occurs
- A timeout expires

Servers MUST ensure duplicated submissions do not:

- Reapply Events
- Change global ordering
- Affect side effects beyond acknowledgement

---

## 7. Optional Extensions

The core protocol is intentionally minimal. Implementations MAY extend it with:

- Compression
- Encryption
- CRDT payloads
- Live presence or ephemeral collaboration metadata
- Snapshotting or pruning strategies

Extensions MUST NOT change the meaning of core fields or break compatibility.

---

## 8. Lifecycle Summary

 Client edits locally → Event created → Added to Pending Outbox → Next heartbeat → Systole: send events + offset → Server processes + assigns ordering →
Diastole: acknowledgements + new events → Client updates projection + offset →
Cycle repeats.


---

## 9. Implementation Responsibility Summary

| Responsibility | Client | Server |
|---------------|--------|--------|
| Generate local events | Yes | No |
| Assign global ordering | No | Yes |
| Maintain append-only event store | No | Yes |
| Maintain local projection | Yes | Optional |
| Retry and backoff behavior | Yes | Optional pacing hints |

---

This overview provides the conceptual framework for understanding the detailed wire format, client responsibilities, and server responsibilities defined in later documents.

