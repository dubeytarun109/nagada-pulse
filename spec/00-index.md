# Nagada Specification (Draft)

**Version:** `0.1.0`  
**Status:** Draft — subject to revision  
**License:** Apache-2.0

---

## Document Structure

This specification is divided into multiple parts to separate philosophy, definitions, and implementation behaviors.

| File | Purpose |
|------|---------|
| `01-philosophy.md` | High-level intent and design principles guiding the protocol. |
| `02-terminology.md` | Formal definitions of protocol terms used throughout the specification. |
| `03-protocol-overview.md` | System model, architecture, actors, and sync lifecycle. |
| `04-wire-format.md` | JSON or binary wire schema definitions (request/response payloads). |
| `05-client-behavior.md` | Required, recommended, and optional client-side rules. |
| `06-server-behavior.md` | Required, recommended, and optional server-side rules. |
| `07-conflict-resolution.md` | Strategies and extensibility model for resolving concurrent writes. |
| `08-versioning-and-compatibility.md` | Rules for backward compatibility, protocol upgrades, and negotiation. |
| `09-conformance-tests.md` | Requirements and scenarios for testing compliant implementations. |

Some documents may reference others. If conflicts exist, this index identifies the most authoritative version. When possible, the specification favors clarity over strict formalism, but future revisions may include machine-verifiable forms.

---

## Scope

This specification defines:

- The sync protocol  
- Required client and server behaviors  
- Event ordering and retry guarantees  
- The logical model behind projections and offsets  

It does **not** define:

- Schema formats  
- UI behavior  
- Storage engines  
- Authorization models  

(See `01-philosophy.md` and `03-protocol-overview.md`.)

---

## Normative Language

The following keywords indicate requirement levels:

- **MUST**
- **MUST NOT**
- **SHOULD**
- **SHOULD NOT**
- **MAY**

They follow the meaning defined in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119).

---

## Future Evolution

This specification is expected to evolve iteratively. Proposals, feedback, and errata are tracked using: .github/ISSUES.md .github/DISCUSSIONS.md

A protocol versioning strategy will be formalized in `08-versioning-and-compatibility.md`. New readers should begin with:

    01-philosophy.md → 02-terminology.md → 03-protocol-overview.md before implementing or reviewing wire formats.
