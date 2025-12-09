````markdown
# Nagada-Pulse Reference Clients

**Status:** Draft

This document collects the canonical reference client implementations and examples for Nagada-Pulse.

Purpose

- Provide reference client implementations that demonstrate correct protocol usage
- Serve as examples for language-specific SDKs (JavaScript, Dart, etc.)
- Support interoperability tests against the reference server

Supported Reference Clients

The repository contains example clients intended for learning and SDK development. These are reference-quality examples, not production-ready SDKs.

- `reference/client/dart` — minimal Dart client and example
- (future) `reference/client/js` — JavaScript example client

Running examples

Each client folder will include a short README with how to run the example. The Dart example can be run from `reference/client/dart`:

```bash
cd reference/client/dart
dart pub get
dart run example/simple_console_app.dart
```

Conformance

Reference clients must remain aligned with the protocol specification. Where behavior differs, the spec (`/spec`) is authoritative.

Contributions

Implementations, bug fixes, and additional language examples are welcome. Before proposing protocol-impacting changes, review `GOVERNANCE.md` and the spec.

````
