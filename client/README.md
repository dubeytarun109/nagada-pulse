# Nagada Client

This directory is reserved for client-side implementations and SDKs for the Nagada Sync Protocol.

## Overview

A Nagada-compatible client is responsible for:

1. **Local State Management** – Maintaining projection database and pending outbox
2. **Event Generation** – Creating immutable client events on local changes
3. **Sync Cycle Execution** – Periodically sending pending events and receiving server updates
4. **Idempotency** – Retrying safely without duplicating events
5. **Conflict Handling** – Respecting server-side conflict resolution decisions

## Specification Reference

- **Full specification:** [`../spec/05-client-behavior.md`](../spec/05-client-behavior.md)
- **Wire format:** [`../spec/04-wire-format.md`](../spec/04-wire-format.md)
- **Terminology:** [`../spec/02-terminology.md`](../spec/02-terminology.md)

## Expected Client Implementations

Roadmap includes reference implementations in:
- Dart (v0.2)
- JavaScript (v0.4)
- Flutter/mobile (v0.6)

## Implementation Checklist

- [ ] Persistent outbox for pending events
- [ ] Local projection store
- [ ] Last known server event ID tracking
- [ ] Heartbeat scheduling (immediate + periodic)
- [ ] Sync request/response handling
- [ ] Event deduplication on retry
- [ ] Projection rebuild capability
- [ ] Error handling and exponential backoff
- [ ] Conformance test compliance

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on submitting client implementations.
