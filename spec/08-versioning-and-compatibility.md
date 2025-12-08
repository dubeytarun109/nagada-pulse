# Versioning and Compatibility

Nagada is intended to evolve while maintaining interoperability. This document defines how implementations negotiate compatibility and how breaking changes are managed.

---

## 1. Version Format

Protocol versions follow:

MAJOR.MINOR.PATCH


Examples: `0.1.0`, `1.0.0`, `1.2.3`

---

## 2. Semantic Meaning

| Component | Meaning | Rules |
|----------|---------|-------|
| **MAJOR** | Breaking changes | MAY require client upgrade |
| **MINOR** | Backward-compatible additions | Older clients MUST ignore new fields safely |
| **PATCH** | Bug fixes or clarifications | No schema or meaning change allowed |

---

## 3. Client Responsibility

Clients MAY send:

```json
{ "protocolVersion": "0.1.0" }
```

If omitted, default compatibility assumption is lowest supported version.

Clients MUST be prepared to:

ignore unknown fields

retry upgrade negotiation once if mismatch detected


## 4. Server Responsibility

Servers MAY reply with a version-negotiation error:
```json
{
  "status": "INCOMPATIBLE_VERSION",
  "requiredVersion": ">=1.0.0",
  "supportedVersions": ["1.0.x", "1.1.x"]
}
```

Servers SHOULD remain tolerant of minor version gaps where semantic meaning is preserved.

## 5. Deprecation Model

Changes MUST follow:

Introduce new feature as optional.

Mark old field as deprecated.

Support transition period.

Remove only in next MAJOR release.

## 6. Transport Independence

Transport-layer version negotiation MUST NOT alter wire semantics. Different transports MAY use transport-specific upgrade negotiation flows.

## 7. Conformance and Future-Proofing Rules

New fields MUST be optional unless major version change.

Unknown keys MUST NOT break behavior.

Required keys MUST NOT be renamed or removed without a major bump.

Implementations SHOULD treat compatibility strictly to avoid protocol drift.


 