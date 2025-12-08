# Terminology

This document defines vocabulary used throughout the Nagada specification. Terms are capitalized when used with protocol meaning.

---

### Client

A device or application instance capable of generating local events and participating in synchronization cycles.

---

### Server

The authoritative event coordinator responsible for assigning global ordering and returning new events to clients.

---

### Event

An immutable record of a user or system action. Events are the foundational unit of synchronization. Once committed, an Event MUST NOT be modified or deleted.

---

### Client Event

An Event generated locally by a Client before global assignment. Identified by a `{deviceId, clientEventId}` pair.

---

### Server Event

An Event after being accepted by the server and assigned a `serverEventId`. Server Events form the global event stream.

---

### Pending Outbox

A client-side, append-only queue storing Client Events awaiting successful acknowledgment by the server.

---

### Projection (or Local Projection Store)

A locally maintained materialized state derived from applying Server Events in order. Projections are rebuildable and not considered source of truth.

---

### Last Known Server Event ID

An integer stored on the client indicating the highest sequential Server Event successfully applied to the local projection.

---

### Sync Cycle

A single exchange containing:

- A **Systole** phase (Client → Server)
- A **Diastole** phase (Server → Client)

Each cycle updates offsets, events, and projections.

---

### Systole

The outbound portion of a Sync Cycle in which the Client sends:

- Pending Client Events
- The Last Known Server Event ID

---

### Diastole

The inbound portion of the Sync Cycle in which the Server sends:

- Acknowledgements for received Client Events
- Server Events newer than the client’s known offset
- Optional pacing metadata

---

### Idempotency

A guarantee that repeating the same Sync Cycle request does not duplicate events or corrupt ordering.

---

### Conflict Resolution

A strategy for handling divergent modifications to the same logical entity. The protocol does not dictate a single strategy; implementations MAY define policies.

---

### Heartbeat

The repeating invocation of the Sync Cycle, whether triggered by local change or scheduled pacing.

