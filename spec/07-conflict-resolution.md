# Conflict Resolution

This document defines the responsibilities and mechanisms for handling conflicting updates to the same logical entity in Nagada. Conflict handling is implementation-specific, but the protocol defines when, where, and how conflicts must be expressed.

---

## 1. Philosophy

Nagada treats all incoming client updates as **proposed events** rather than authoritative state mutations.

Conflicts occur when:

- Multiple devices modify the same entity independently.
- Event ordering changes meaning (e.g., update before delete).
- Domain rules forbid certain combinations of event consequences.

The server is responsible for conflict interpretation.

---

## 2. Resolution Principles

All conflict resolution MUST adhere to:

| Principle | Requirement |
|----------|-------------|
| **History is immutable** | Conflicts MUST NOT delete or mutate existing events. |
| **Outcome must be explicit** | Resolution MUST be represented as one or more new events. |
| **Deterministic replay** | Replaying the event stream MUST produce the same result. |
| **Client ignorance tolerance** | Clients MUST NOT need custom logic to detect conflicts unless optional. |

---

## 3. Classes of Strategies

Nagada supports multiple resolution strategies. Implementations MAY choose one or mix them by domain rules.

### 3.1 Last-Write-Wins (LWW)

The most recent event according to server ordering supersedes earlier events.

Use cases:

- Simple immutable field updates
- Timestamp-based record changes

### 3.2 Field-Level Merge

Only modified fields overwrite corresponding fields in previous state.

Example: Form updating name but not address.

### 3.3 CRDT-Based Resolution

Payloads MAY embed CRDT semantics (e.g., OR-Set, G-Counter), allowing conflict-free merging.

The protocol does not mandate CRDT interoperability.

### 3.4 Human Review / Deferred Resolution

Server MAY create a resolution-required event. Clients SHOULD treat as read-only until resolved.

Example:

```json
{ "type": "CONFLICT_REQUIRES_REVIEW", "entityId": "invoice-22" }
````

## 4 Resolution Output Format

    Resolution MUST produce one of:

    A compensating event
    A replacement event
    A merge event
    A rejection event

    Example compensating event:

 ```json
    {
    "serverEventId": 312,
    "type": "NAME_MERGE_RESOLVED",
    "entityId": "user-88",
    "payload": {
      "mergedName": "Alice B. Cooper"
        }
    }
````
## 5. Client Expectations

Clients MUST:

Apply resolution events like ordinary Server Events.

MUST NOT delete or alter their own pending history solely because a conflicting event appears.

## 6. Server Expectations

Servers SHOULD:

Ensure consistency of conflict outcomes across retries.

Preserve client intent where possible.

## 7. Extensibility

Future versions MAY add formal conflict classes or machine-readable merge policies.

----