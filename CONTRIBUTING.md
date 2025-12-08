# Contributing to Nagada

Thank you for your interest in contributing to the **Nagada Sync Protocol**.  
This project welcomes feedback, discussion, and collaboration as it evolves from draft to stable standard.

---

## Project Structure

Nagada is a **specification-first** project. Implementations, SDKs, and tooling may live in separate repositories, but this repository defines:

- The formal specification (`/spec`)
- Documentation and reference material
- Conformance expectations
- Roadmap and governance

Changes to the protocol require careful review to avoid fragmentation.

---

## Before You Start

Please read:

1. `spec/01-philosophy.md` – for protocol intent  
2. `spec/02-terminology.md` – shared vocabulary  
3. `spec/03-protocol-overview.md` – the lifecycle model  

These documents ensure new contributions align with the guiding principles.

If you're unsure whether an idea fits, open a **Discussion** first.

---

## Types of Contributions

You may contribute in any of the following areas:

| Contribution Type | Examples |
|-------------------|----------|
| Specification improvements | clarifications, restructuring, error fixes |
| Feature proposals | new protocol optional fields, extensions, modular components |
| Conformance tests | new scenarios, validation rules |
| Documentation | diagrams, examples, glossary expansion |
| Implementations | reference client/server SDKs, tooling |
| Feedback and review | spec critique, proposals, use cases |

---

## Proposing Changes to the Spec

Specification changes follow this flow:

1. Open a **GitHub Discussion** describing:
   - The problem being solved
   - Alternatives considered
   - Expected impact and compatibility
2. After community feedback, open a **Pull Request**.
3. The PR MUST follow the structure:
   - Motivation
   - Proposed change
   - Backward compatibility impact
   - Conformance implications

Breaking or behavioral changes MAY require updating:

- `08-versioning-and-compatibility.md`
- conformance tests
- wire format expectations

---

## ✔️ Style & Language Rules

- Use **normative language** (`MUST`, `SHOULD`, `MAY`) as defined in RFC 2119.
- Avoid implementation assumptions (specific DBs, frameworks, languages).
- Keep specification neutral, minimal, and interoperable.
- Include diagrams only if they clarify behavior.

Markdown formatting conventions:

- Use fenced code blocks for JSON or examples.
- Keep tables consistent.
- Use heading hierarchy (`# → ## → ###`).

---

## Filing Issues

Use issues for:

- Clear bugs in the specification
- Typos or formatting issues
- Missing clarification requests

Use Discussions for:

- Feature ideas
- Architectural debate
- Open questions
- Philosophy or tradeoff conversations

---

## Pull Request Process

Before submitting a PR:

- Ensure the content matches project goals.
- Run a self-check using the PR checklist in `.github/PULL_REQUEST_TEMPLATE.md`.
- Reference relevant specification sections.

Once submitted:

- A maintainer or reviewer will evaluate wording, compatibility, and consistency.
- Requested changes may include reformulation for clarity or neutrality.

---

## Licensing

By contributing, you agree your contributions are licensed under:

