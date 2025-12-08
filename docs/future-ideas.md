# Future Ideas and Research

This document captures ideas, research directions, and potential extensions for the Nagada Sync Protocol that are being considered for future versions.

## Vision

Nagada is designed to evolve while maintaining core stability. This document tracks ideas that may become roadmap items or optional protocol extensions.

---

## Proposed Extensions

See the `/extensions/` directory for detailed proposals on:

- **WebSocket Transport** (`extensions/websocket-transport.md`) – Real-time bidirectional sync
- **CRDT Payload Support** (`extensions/crdt-payload-proposal.md`) – Native CRDT event payloads
- **Snapshotting Strategy** (`extensions/snapshotting-strategy.md`) – Event pruning and state snapshots

---

## Research Areas

### Live Presence and Awareness

- Real-time cursor position sharing
- User presence indicators
- Ephemeral awareness metadata
- Integration with sync cycle vs. separate channel

### Compression and Bandwidth Optimization

- Delta encoding for large payloads
- Gzip or Brotli support in wire format
- Batch compression across multiple events
- Trade-offs between CPU and bandwidth

### Advanced Conflict Resolution

- Semantic conflict detection (beyond last-write-wins)
- Machine learning-based conflict prediction
- Multi-factor conflict strategies
- Conflict explanation and auditability

### Sharding and Partitioning

- Data partitioning across multiple event stores
- Partition-aware sync strategies
- Cross-partition ordering guarantees
- Fallback and recovery mechanisms

### Performance and Scalability

- Horizontal scaling of event stores
- Event pruning without losing auditability
- Snapshot consistency
- Load-balancing strategies for servers

### Security Extensions

- End-to-end encryption for payloads
- Signature verification and tamper detection
- Zero-knowledge proofs for privacy-preserving sync
- Blockchain-based immutability verification (research only)

---

## Rejected Ideas (and Why)

### Real-Time Collaborative Editing at Protocol Level
- **Decision:** Out of scope for core protocol
- **Rationale:** Conflict resolution and CRDT semantics belong to application layer
- **Alternative:** Applications can use CRDT payloads within Nagada events

### Automatic Schema Evolution
- **Decision:** Not mandated by specification
- **Rationale:** Schema is application-domain-specific
- **Alternative:** Applications manage schema versions independently

### Centralized Registry or Discovery
- **Decision:** Not part of core protocol
- **Rationale:** Nagada is transport and deployment-agnostic
- **Alternative:** Implementations may provide optional discovery layers

---

## Community Input

Ideas from community members are welcome! Please:

1. Open a **Discussion** in `.github/discussions/`
2. Reference this document
3. Clearly articulate the problem and proposed solution
4. Include use cases and examples
5. Discuss trade-offs

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

---

## Versioning and Stability

- **v0.x:** Experimental features and major changes
- **v1.0+:** Core protocol stability; extensions via optional fields
- **Extensions:** May be versioned independently; core version independent of extension versions

