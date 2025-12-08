# Nagada Examples

This directory contains example implementations, pseudocode, and use cases for the Nagada Sync Protocol.

## Structure

### Pseudocode Examples
- `sync-cycle-pseudocode.md` – Basic heartbeat loop
- `client-state-management.md` – Local projection and outbox handling
- `server-event-ordering.md` – Global event stream ordering

### Use Cases
- `offline-first-mobile-app.md` – Mobile app with offline support
- `distributed-team-collaboration.md` – Multi-device team workflow
- `iot-device-sync.md` – Constrained network synchronization

### Reference Implementations
Reference implementations in various languages will be added as the specification stabilizes.

## Getting Started

1. Read the specification in `/spec/` (start with `spec/01-philosophy.md`)
2. Review the wire format in `spec/04-wire-format.md`
3. Study the examples in this directory
4. Implement according to the conformance tests in `spec/09-conformance-tests.md`

## Contributing Examples

Have a useful example or pattern? Open a PR with:
- Clear problem statement
- Pseudocode or reference implementation
- Explanation of protocol features used
- Any lessons learned

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.
  "pendingEvents": [
    {
      "clientEventId": "dev-xyz-1",          // unique per device
      "type": "BOOK_UPDATED",
      "entityId": "book-1001",
      "timestamp": "2025-12-07T09:10:11Z",   // when client created event
      "payload": {
        "title": "New Title",
        "author": "Author Name"
      }
    }
  ]
}
```

### Server → Client (“Diastole”) response JSON
```json

{
  "status": "OK",
  "ackedClientEventIds": ["dev-xyz-1"],
  "newServerEvents": [
    {
      "serverEventId": 12346,
      "type": "BOOK_UPDATED",
      "entityId": "book-1001",
      "timestamp": "2025-12-07T09:10:30Z",
      "payload": {
        "title": "New Title",
        "author": "Author Name"
      }
    }
  ],
  "nextHeartbeatMs": 3000
}

