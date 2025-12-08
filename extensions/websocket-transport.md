# WebSocket Transport Extension

**Status:** Proposed (Roadmap v0.7)  
**Author(s):** Nagada Community  
**Last Updated:** 2025-12-08

---

## Overview

This proposal defines an optional **WebSocket transport** for Nagada sync cycles, enabling real-time bidirectional communication between clients and servers.

The WebSocket transport is **optional** and does not change core protocol semantics—the heartbeat cycle, event ordering, and sync guarantees remain identical.

---

## Motivation

While HTTP POST is reliable and widely compatible, WebSocket provides advantages for certain use cases:

- **Lower latency:** Persistent connection eliminates handshake overhead
- **Real-time push:** Server can proactively deliver events without polling
- **Reduced bandwidth:** Connection reuse and absence of HTTP headers
- **Better mobile performance:** Fewer context switches and reconnections

---

## Design

### Connection Establishment

```
Client → Server: WebSocket upgrade request
  GET /api/sync/ws HTTP/1.1
  Upgrade: websocket
  Connection: Upgrade
  Sec-WebSocket-Key: ...
  Sec-WebSocket-Version: 13

Server → Client: Upgrade accepted (HTTP 101)
```

### Message Format

Messages are JSON-encoded, identical to HTTP payloads:

```json
{
  "type": "sync-request",
  "payload": {
    "deviceId": "...",
    "lastKnownServerEventId": 120,
    "pendingEvents": [...]
  }
}
```

Server response:

```json
{
  "type": "sync-response",
  "payload": {
    "status": "OK",
    "acknowledgedEventIds": [...],
    "newServerEvents": [...],
    "nextHeartbeatMs": 3000
  }
}
```

### Heartbeat Timing

- Client initiates sync cycles based on `nextHeartbeatMs` or local changes (unchanged)
- Server pushes new events proactively if connection is open and new events arrive
- If connection drops, client falls back to HTTP polling or reconnection retry

### Error Handling

Close codes:

| Code | Meaning |
|------|---------|
| 1000 | Normal closure |
| 1008 | Policy violation (e.g., incompatible version) |
| 1009 | Message too big |
| 1011 | Server error |
| 3000–3999 | Custom protocol errors (e.g., authentication failure) |

---

## Backward Compatibility

- HTTP POST remains the required baseline
- WebSocket is purely optional
- Clients not supporting WebSocket continue using HTTP
- No changes to core sync semantics

---

## Implementation Notes

### Server-Side
- Maintain persistent connection state per device
- Handle disconnections and reconnections gracefully
- Resume sync from last known offset after reconnection
- Implement message queue for events arriving while client is offline

### Client-Side
- Attempt WebSocket connection on startup
- Fall back to HTTP if WebSocket is unavailable (blocked port, no support, etc.)
- Implement exponential backoff for reconnection
- Maintain local sync state independently of transport

---

## Security Considerations

- Use **WSS (WebSocket Secure)** over TLS in production
- Authenticate via token or cookie before upgrading
- Validate `Sec-WebSocket-Key` to prevent cross-protocol attacks
- Implement rate limiting to prevent resource exhaustion

---

## Testing

Conformance tests should verify:

- [ ] Sync cycles over WebSocket are semantically identical to HTTP
- [ ] Message ordering is preserved
- [ ] Reconnection resumes from correct offset
- [ ] Fallback to HTTP works transparently
- [ ] Error responses are properly parsed

---

## Non-Goals

- This extension does **not** replace HTTP as the primary transport requirement.
- It does **not** introduce new message types or modify sync semantics.
- It does **not** guarantee sub-100ms realtime collaboration (CRDT or OT systems may layer on top separately).
- It does **not** define multiplexing, binary encoding, or compression—these may be future extensions.

---

## Transport Responsibilities

| Layer | Responsibility |
|-------|---------------|
| Protocol | Defines sync semantics (unchanged) |
| HTTP / WebSocket Transport | Delivers sync request/response messages |
| Client | Schedules sync cycles, retry strategy, state tracking |
| Server | Maintains ordered event log and per-device sync offsets |

---

## Capability Detection (Optional Future Work)

A future version MAY allow clients to advertise supported transports via a `capabilities` field in the initial sync request:

```json
{
  "deviceId": "...",
  "capabilities": {
    "supportsWebSocket": true
  }
}
```

Servers MAY use this field to decide whether to offer WebSocket upgrade paths or fallback to HTTP polling.

This keeps it flexible without requiring negotiation in v0.7.

---

## Summary

The WebSocket transport extension enhances performance for applications that benefit from low-latency bidirectional communication while maintaining Nagada's core guarantees and ensuring full backward compatibility with existing HTTP-based clients.

---

## Future Enhancements

- Binary frame support for reduced bandwidth
- Multiplexing multiple sync streams over single connection
- Server-initiated sync requests for specific devices
- Streaming large event batches

