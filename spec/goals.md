# Goals

Nagada exists to create a **unified, predictable, offline-first synchronization protocol** that works across devices, platforms, and network conditions.

It focuses on the following core objectives:

| Category | Goal |
|----------|------|
| **Reliability** | Ensure deterministic eventual consistency across multiple devices, even in intermittent or unreliable networks. |
| **Event-Sourcing Foundation** | Model all changes as immutable events with global ordering established only by the server. |
| **Offline-First** | Allow clients to read and write without connectivity, storing pending changes locally until sync occurs. |
| **Idempotency & Safety** | Support safe retries, duplicate detection, and conflict avoidance without requiring special-case application logic. |
| **Minimal Client State** | Clients store only projections, pending events, and the last known server event ID—never global truth. |
| **Framework Agnosticism** | Provide reference implementations but keep the core specification independent of languages and frameworks. |
| **Simple First Transport** | Use HTTP POST as the baseline sync channel, with optional real-time transports (WebSockets, gRPC, SSE). |
| **Auditability & Replay** | Support rebuilding projections, debugging history, and proving data lineage via append-only logs. |
| **Pluggable Conflict Resolution** | Allow multiple strategies (LWW, CRDT payloads, human review) without baking conflict policy into the protocol itself. |
| **Spec-as-Source-of-Truth** | Define behavior in an implementation-independent specification before building SDKs or frameworks. |


---

## Non-Goals

Nagada intentionally avoids scope creep into areas better handled by other systems.

| Category | Non-Goal |
|----------|----------|
| **Not a Database** | Nagada does not define or mandate internal storage engines, schemas, or indexing strategies. |
| **Not a Query Language** | It does not provide SQL/GraphQL-style querying — projections or views are outside the core protocol. |
| **Not a Replacement for Firestore/CouchDB** | It is not intended as a drop-in competitive clone of existing DB synchronization ecosystems. |
| **Not Real-Time Editing First** | Sub-100ms live collaboration sync (cursor merging/OT/CRDT streams) is optional, not central. |
| **Not a Pub/Sub Messaging System** | Nagada is not Kafka, MQTT, or a websocket event bus, though transports may overlap. |
| **Not Tied to Cloud or Offline Exclusively** | It supports both patterns but enforces neither deployment model. |
| **Not Domain-Aware** | No business rules, validation logic, or entity semantics are defined by the protocol. |
| **Not a Security Framework** | Authentication, authorization, identity, and encryption are layered concerns implemented externally. |
| **Not Monolithic or Centralized** | The protocol is designed for interoperability; implementations may vary across stacks and storage types. |

