# Nagada Protocol Philosophy

Nagada is built on the premise that distributed applications should remain usable, predictable, and consistent regardless of connectivity. The protocol is designed to enable seamless offline-first behavior through deterministic synchronization, while remaining neutral to storage engines, programming languages, or application frameworks.

Nagada is **not a product or implementation** — it is a **protocol and behavioral contract**. Implementations may vary, but systems claiming compatibility must conform to the principles, guarantees, and responsibilities described in this specification.

---

## 1. Purpose

The purpose of Nagada is to define a synchronization model where clients operate autonomously during offline states and later converge to a globally consistent state through an event-based sync cycle.

The protocol aims to:

- Support unreliable or intermittent connectivity.
- Enable event replay, auditability, and projection rebuilding.
- Ensure idempotent synchronization with recoverable ordering semantics.
- Remain simple to implement as the smallest primitive in distributed state sync.

---

## 2. Core Principles

The design of Nagada is guided by the following principles:

| Principle | Description |
|----------|-------------|
| **Offline-first** | Clients must function without network access and synchronize opportunistically. |
| **Event Immutability** | All client-originated changes are represented as immutable events rather than direct state mutations. |
| **Deterministic Ordering** | The server assigns a monotonically increasing global ordering (`serverEventId`) to establish causality across devices. |
| **Idempotency** | Sync operations must be safe to repeat without side effects. Duplicate event submissions must not corrupt global state. |
| **Minimal Required State** | Clients maintain only: local projection, pending outbox, and last processed server event offset. |
| **Protocol Stability** | Implementations may change, but the protocol must remain predictable, measurable, and backward compatible when feasible. |
| **Spec Over Implementation** | Behavior should be defined through specification, not inferred from reference code. |

---

## 3. Goals

Nagada is designed to meet the following goals:

- Provide a clear, implementation-agnostic synchronization contract.
- Define a predictable and repeatable sync cycle using a heartbeat mechanism.
- Enable reconstruction of application state from historical events.
- Support pluggable conflict strategies without enforcing a universal one.
- Allow varying storage technologies and transport protocols without compromising semantics.
- Enable deterministic eventual consistency regardless of device count or sequence of edits.

---

## 4. Non-Goals

Nagada intentionally avoids assuming responsibilities outside the scope of synchronization. The following are explicitly out of scope for the core protocol:

- **Database abstraction** — Nagada does not define schemas, collections, or query systems.
- **Domain semantics** — Event meaning, validation, and resolution strategies belong to applications.
- **Real-time collaborative cursor or OT/CRDT semantics** — These may be layered on top but are not required or assumed.
- **Messaging or pub/sub transport roles** — Nagada is not a general event push, streaming, or notification system.
- **Authentication and authorization** — Security models are external and transport-dependent.
- **Centralized framework design** — The protocol does not require a single canonical storage or runtime implementation.

---

## 5. Intended Usage

Nagada is intended for systems where:

- Multiple devices or actors may modify data independently.
- Network reliability is unpredictable.
- Auditability, replay, or debugging of historical state is valuable.
- Deterministic ordering and causality matter more than real-time latency.

Representative domains include:

- Mobile/PWA applications with offline requirements  
- IoT devices and constrained networks  
- Distributed field data collection  
- Workflow and operational tracking systems  
- Event-sourced applications and CQRS architectures  

---

## 6. Summary

Nagada is a synchronization worldview prioritizing resilience, determinism, and autonomy. It treats synchronization not as a continuous live stream, but as a controlled heartbeat rhythm in which convergence occurs through immutable events and global ordering assignment.

Implementations may evolve; the philosophy should remain stable.

