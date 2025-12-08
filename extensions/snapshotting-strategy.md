# Snapshotting Strategy Proposal

**Status:** Proposed (Roadmap v0.8)  
**Author(s):** Nagada Community  
**Last Updated:** 2025-12-08

---

## Overview

This proposal defines an optional **snapshotting mechanism** for Nagada, enabling servers and clients to:

1. Prune old events from the event store to reclaim storage
2. Quickly bootstrap new or recovering devices with materialized state
3. Improve sync performance by reducing event log traversal

---

## Motivation

As event logs grow, challenges emerge:

- **Storage cost:** Event stores grow indefinitely
- **Sync latency:** Clients with large offset gaps must replay thousands of events
- **New devices:** Bootstrapping from event 0 is inefficient

Snapshotting addresses these by periodically creating point-in-time state captures.

---

## Design

### Snapshot Format

A snapshot is a **serialized projection** at a specific `serverEventId`:

```json
{
  "snapshotId": "snap-12345",
  "serverEventId": 5000,
  "timestamp": "2025-12-08T10:00:00Z",
  "projectionData": {
    "entities": {
      "doc-1": { "title": "Hello", "text": "World" },
      "doc-2": { "title": "Foo", "text": "Bar" }
    },
    "metadata": {
      "version": 1,
      "checksum": "sha256:abc123"
    }
  }
}
```

### Server-Side Snapshotting

**Trigger Points:**
- Time-based: Every N days
- Event-based: Every M events
- Manual: On-demand via admin API
- Hybrid: Combination of above

**Process:**

1. Materialize projection from event 0 to `snapshotEventId`
2. Serialize projection state
3. Store snapshot with metadata
4. Mark events before snapshot as "eligible for archival"
5. Optionally delete or archive old events

### Client-Side Snapshot Usage

**Bootstrap with Snapshot:**

```json
{
  "deviceId": "device-xyz",
  "userId": "user-123",
  "lastKnownServerEventId": 0,
  "requestSnapshot": true,
  "requestSnapshotId": "snap-12345"
}
```

**Server Response:**

```json
{
  "status": "OK",
  "snapshot": {
    "snapshotId": "snap-12345",
    "serverEventId": 5000,
    "projectionData": { ... }
  },
  "newServerEvents": [
    // Events after snapshot (5001, 5002, ...)
  ],
  "nextHeartbeatMs": 3000
}
```

**Client Processing:**

1. Receive snapshot
2. Initialize local projection with snapshot data
3. Set `lastKnownServerEventId = snapshot.serverEventId`
4. Apply any `newServerEvents` normally
5. Full sync state achieved

---

## Consistency Guarantees

### Snapshot Integrity

- **Checksum:** Include SHA256 or similar to detect corruption
- **Version:** Snapshot format version for evolution
- **Immutability:** Once created, snapshots are read-only
- **Audit trail:** Keep record of snapshot creation (who, when, why)

### Event Log Consistency

After snapshotting, event store must maintain:

1. **Monotonic ordering** – Events before and after snapshot boundary
2. **No gaps** – Even if early events are archived
3. **Offset continuity** – `serverEventId` sequence unbroken

---

## Archival vs. Deletion

### Conservative Approach: Archive Only
- Keep old events in cold storage (S3, archive tier)
- Maintain fast log for recent events
- Enable historical reconstruction if needed
- Trade: Storage cost vs. compliance/auditability

### Aggressive Approach: Delete
- Permanently remove events before snapshot
- Minimum storage footprint
- Trade: No ability to reconstruct history pre-snapshot
- May violate compliance requirements

**Recommendation:** Archive by default; delete only if compliance allows.

---

## Backward Compatibility

- Snapshots are optional (no breaking changes)
- Clients without snapshot support work unchanged
- Servers can operate with or without snapshotting
- Hybrid mode: Some clients use snapshots, others don't

---

## Wire Format Changes

Optional new fields in sync response:

```json
{
  "status": "OK",
  "acknowledgedEventIds": [...],
  "newServerEvents": [...],
  "snapshot": {
    "snapshotId": "...",
    "serverEventId": 5000,
    "timestamp": "...",
    "projectionData": { ... },
    "checksum": "sha256:..."
  },
  "snapshotAvailable": true
}
```

---

## Implementation Considerations

### Projection Serialization

- **Format:** JSON by default (extensible to MessagePack, Protobuf)
- **Size:** Compress if > 1 MB
- **Delta:** Optional: Store incremental snapshots (snapshot + deltas) for efficiency

### Orphaned Snapshots

- Old snapshots may become outdated if schema changes
- Keep metadata linking snapshots to protocol/schema versions
- Clients validate compatibility before use

### Recovery Scenarios

**Scenario 1: Snapshot Corruption**
- Server detects checksum mismatch
- Rejects snapshot request
- Responds with `"snapshotAvailable": false`
- Client falls back to event replay

**Scenario 2: Snapshot Not Found**
- Requested snapshot ID doesn't exist
- Server responds with newest available snapshot
- Or responds without snapshot (fallback)

---

## Performance Implications

### Storage
- **Before:** Event store grows indefinitely
- **After:** Event store + snapshots (older events archived/deleted)
- **Net:** Significant space savings with archival

### Sync Time
- **Cold start (no snapshot):** O(N) where N = total events
- **Cold start (with snapshot):** O(M) where M = events since snapshot
- **Warm sync (from offset):** O(K) where K = new events since last sync (unchanged)

### CPU
- **Snapshot creation:** High CPU once; amortized over many syncs
- **Snapshot application:** One-time per device/session

---

## Security Considerations

- Snapshots may contain sensitive data (PII, credentials)
- Apply same encryption and access controls as events
- Audit snapshot access and creation
- Include snapshot metadata in compliance logs

---

## Testing

Conformance tests should verify:

- [ ] Snapshot creation preserves projection state
- [ ] Checksum validation detects corruption
- [ ] Client snapshot bootstrap produces identical state as event replay
- [ ] New events after snapshot apply correctly
- [ ] Snapshot and event replay converge
- [ ] Archival doesn't affect sync semantics
- [ ] Multiple snapshot versions coexist safely

---

## Example: E-Commerce Order History

**Scenario:** Large retailer with 10 years of orders.

**Without Snapshotting:**
- Event log: 1 billion events
- New device sync: Replay all 1B events (hours)
- Storage: 500 GB

**With Snapshotting (weekly snapshots):**
- Snapshots: 520 total (one per week)
- Oldest events: Archived after 1 month of inactivity
- Fast log: Last week of events (5 million) = 2.5 GB
- New device sync: Load last snapshot + recent events (minutes)
- Storage: 5 GB fast + 50 GB archive

---

## Non-Goals

- Snapshots do **not** replace the append-only event log as the canonical source of truth.
- Snapshotting does **not** alter sync semantics or message ordering.
- Snapshots do **not** introduce new conflict-resolution rules.
- Clients are not required to support snapshotting to remain protocol compliant.

---

## Execution Responsibility

| Component | Behavior |
|----------|----------|
| Server | Creates, stores, optionally distributes snapshots |
| Client | May request, apply, and cache snapshots |
| Wire Protocol | Only carries snapshot metadata and data (optional) |

### Snapshot Versioning

Snapshots MUST include a `projectionVersion` field so clients can determine compatibility.  
If a snapshot is incompatible with the current projection schema, the client MUST fall back to full event replay.

### CRDT Integration

If CRDT payload support is enabled, snapshots MAY include CRDT materialized state.  
Snapshots MUST remain deterministic under CRDT replay rules.

### Summary

Snapshotting provides a scalable, optional optimization that improves long-term performance and onboarding speed without changing the core Nagada protocol semantics.

---

## Future Enhancements

- Distributed snapshots (P2P sharing for peer recovery)
- Incremental/delta snapshots for bandwidth efficiency
- Periodic consistency checks between snapshot and event log
- Snapshot tiering (hot/warm/cold storage)
- Blockchain-based snapshot verification (research)

