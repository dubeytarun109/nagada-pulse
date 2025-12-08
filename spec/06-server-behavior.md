# Server Behavior

This document defines the authoritative responsibilities of Nagada-compatible servers.

---

## 1. Global Event Store

The server MUST maintain an append-only log of Server Events. Events MUST NOT be modified or deleted once committed.

---

## 2. Event Ordering and Deduplication

Upon receiving a Sync Request, the server MUST:

| Step | Behavior |
|------|----------|
| 1 | Identify each submitted Client Event by (`deviceId`, `clientEventId`). |
| 2 | Reject duplicates without reapplying. |
| 3 | Append new events and assign sequential `serverEventId`. |

Event order MUST be strictly monotonic within the global stream.

---

## 3. Offset Tracking

The server MUST track: (deviceId → lastDeliveredServerEventId)


This enables efficient diff-based response generation.

---

## 4. Response Generation

The server MUST construct a Sync Response containing:

- All acknowledged client event IDs
- All Server Events where `serverEventId > lastKnownServerEventId`
- Optional pacing metadata (`nextHeartbeatMs`)

All Server Events MUST be sorted ascending by `serverEventId`.

---

## 5. Error Handling

The server SHOULD return structured error responses rather than terminating the connection.

Errors MAY include:

| Code | Meaning |
|------|---------|
| `INVALID_REQUEST` | The request is malformed. |
| `UNAUTHORIZED` | Authentication required. |
| `INCOMPATIBLE_VERSION` | Client protocol version unsupported. |
| `SERVER_BUSY` | Temporary pacing hint situation. |

Clients MUST be able to retry unless error explicitly forbids it.

---

## 6. Conflict Resolution

The server MUST treat incoming client edits as *proposals*, not guaranteed final state. If conflicts exist, the server MAY:

- Apply deterministic rules (e.g., LWW)
- Invoke domain logic or business policies
- Generate compensating events
- Queue resolution for human review

The server MUST express resolution outcomes as new Server Events.

---

## 7. Optional Server-Side Projection

Servers MAY maintain read-optimized projections to support downstream consumers. These MUST be rebuildable from event history.

---

## 8. Backpressure & Guidance

Servers MAY include:

```json
"nextHeartbeatMs": 8000
```

to influence pacing based on load, system health, or policies.

Servers MUST NOT enforce client protocol behavior solely through transport failure.

## 9. Implementation Freedom

Servers MAY vary in:

- Storage engines
- Scaling strategy
- Programming language
- Deployment model

as long as they obey all required protocol semantics.

