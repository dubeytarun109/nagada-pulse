# Wire Format

This document defines the canonical representation of messages exchanged between Clients and Servers during synchronization. The default transport is HTTP POST with a JSON payload, although alternate encodings (e.g., Protocol Buffers) MAY be supported as extensions.

All fields explicitly listed below are normative unless marked as *optional*.

---

## 1. Encoding

The baseline encoding format is:

```
Content-Type: application/json; charset=utf-8
```

Values MUST conform to standard JSON types.

Future versions MAY define binary encodings while preserving field semantics.

---

## 2. Common Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `protocolVersion` | string | No | Optional compatibility hint (e.g., `"0.1.0"`). |
| `deviceId` | string | Yes | Unique identifier for the client device. |
| `userId` | string | No | User identity if authenticated context exists. |

---

## 3. Client Event Schema

A Client Event represents an action generated locally before being globally ordered.

```json
{
  "clientEventId": "UUID-v4",
  "type": "DOMAIN_EVENT_NAME",
  "entityId": "string",
  "timestamp": "ISO-8601",
  "payload": { "arbitrary": "JSON" }
}
```

**Requirements:**

- `clientEventId` MUST be globally unique within its originating `deviceId`.
- `timestamp` SHOULD represent local creation time.

## 4. Server Event Schema

A Server Event is the committed, ordered form of a Client Event.

## 5. Sync Request (Systole)

```json
{
  "protocolVersion": "0.1.0",
  "deviceId": "device-abc",
  "userId": "user-123",
  "lastKnownServerEventId": 120,
  "pendingEvents": [ { "...": "ClientEvent" } ]
}
```

## 6. Sync Response (Diastole)

```json
{
  "status": "OK",
  "acknowledgedEventIds": ["uuid-1", "uuid-2"],
  "newServerEvents": [ { "...": "ServerEvent" } ],
  "nextHeartbeatMs": 3000,
  "serverTime": "2025-12-07T10:12:00Z"
}
```

### Field Rules

| Field | Description |
|-------|-------------|
| `status` | MUST be "OK" or error category. |
| `acknowledgedEventIds` | List of client event IDs successfully processed. |
| `newServerEvents` | Sorted ascending by `serverEventId`. |
| `nextHeartbeatMs` | Optional pacing hint. |
## 7. Error Response Format

```json
{
  "status": "ERROR",
  "errorCode": "INCOMPATIBLE_VERSION",
  "message": "Upgrade required.",
  "requiredVersion": ">=0.2.0"
}
```

## 8. Ordering Guarantee

- `newServerEvents` MUST always be sorted ascending by `serverEventId`.
- Clients MUST apply them in the order received.

9. Future Extensions

Payloads MAY include:

compression fields (encoding: "gzip")

delta/patch formats

snapshot metadata

These MUST NOT alter required field semantics.


---

 