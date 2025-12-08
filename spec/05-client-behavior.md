# Client Behavior

This document defines required, recommended, and optional behaviors for Nagada-compatible clients.

---

## 1. Persistent Local State

A compliant client MUST persist:

| Required Data | Purpose |
|---------------|---------|
| `Pending Outbox` | Stores unacknowledged Client Events. |
| `Last Known Server Event ID` | Bookmark into global event stream. |
| `Projection` | Local application state derived from server events. |

Projection format and storage engine are implementation-defined.

---

## 2. Event Creation

When the user performs a data change, the client MUST:

1. Create a new Client Event.
2. Append it to the Pending Outbox.
3. Apply it to the local Projection optimistically.
4. Trigger a heartbeat sooner than scheduled (optional but recommended).

Client Event timestamps SHOULD reflect local creation time; no clock sync is assumed.

---

## 3. Heartbeat Scheduling

A client SHOULD:

- Sync immediately when new local events exist.
- Sync periodically when idle using `nextHeartbeatMs`.
- Apply exponential backoff when repeated errors occur.

---

## 4. Sync Cycle Responsibilities

Upon receiving a Sync Response, the client MUST:

1. Remove all acknowledged event IDs from the Pending Outbox.
2. Apply all `newServerEvents` in ascending order.
3. Update `lastKnownServerEventId` to the highest observed `serverEventId`.

---

## 5. Idempotency

Clients MUST NOT discard or mutate events in the Pending Outbox solely due to retry attempts.

Repeated Sync Requests MUST be treated as logically equivalent until resolved.

---

## 6. Conflict Visibility

Clients MUST NOT assume last-write-wins semantics.  
Any domain-level conflict resolution occurs server-side and MAY create compensating events.

---

## 7. Failure Handling

Clients SHOULD:

- Retry on network error.
- Cache failed requests.
- Pause sync on authentication failure until renewed.

Clients MUST NOT enter unrecoverable failure states solely from invalid last-known offsets.

---

## 8. Projection Rebuild

Clients MUST be able to rebuild Projection state from a stream of Server Events.

Full rebuild MAY occur when:

- Event history changes format.
- Local state corruption is detected.
- Server requests a reset indication.

---

## 9. Optional Enhancements

- Delta compression
- Batched event submission
- Device diagnostics synchronized through metadata

None of these alter mandatory core behavior.