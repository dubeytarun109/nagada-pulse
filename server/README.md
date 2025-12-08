# Nagada Server

This directory is reserved for server-side implementations and reference code for the Nagada Sync Protocol.

## Overview

A Nagada-compatible server is responsible for:

1. **Global Event Store** – Maintaining append-only, immutable event log
2. **Event Ordering** – Assigning monotonically increasing `serverEventId` values
3. **Deduplication** – Rejecting duplicate events by `(deviceId, clientEventId)` pair
4. **Sync Response Generation** – Acknowledging received events and delivering new global events
5. **Conflict Resolution** – Applying configured strategies (LWW, CRDT, human review, etc.)
6. **Per-Device Offset Tracking** – Maintaining sync progress per client

## Specification Reference

- **Full specification:** [`../spec/06-server-behavior.md`](../spec/06-server-behavior.md)
- **Wire format:** [`../spec/04-wire-format.md`](../spec/04-wire-format.md)
- **Conflict resolution strategies:** [`../spec/07-conflict-resolution.md`](../spec/07-conflict-resolution.md)

## Expected Server Implementations

Roadmap includes reference implementations in:
- Minimal HTTP server (v0.1)
- Spring Boot starter (v0.5)
- Alternative runtimes as needed

## Implementation Checklist

- [ ] Append-only event store (with monotonic ordering)
- [ ] Per-device offset tracking
- [ ] Duplicate detection by `(deviceId, clientEventId)`
- [ ] Sync request parsing and response generation
- [ ] Error handling (invalid requests, version negotiation)
- [ ] Conflict resolution strategy pluggability
- [ ] Event stream ordering guarantees
- [ ] Backpressure and pacing hints (`nextHeartbeatMs`)
- [ ] Conformance test compliance

## Storage Considerations

The specification does not mandate a specific storage engine. Implementations may use:
- Relational databases (PostgreSQL, MySQL)
- NoSQL stores (MongoDB, DynamoDB)
- Event streaming platforms (Kafka, Event Hubs)
- Custom append-only logs
- In-memory stores for development

Ensure your storage provides:
- Atomicity for event insertion
- Monotonic ordering
- Durability guarantees for your use case

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on submitting server implementations.
