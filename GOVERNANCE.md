# Nagada Project Governance

**Last Updated:** 2025-12-08

---

## Mission and Values

### Mission

To define and steward the **Nagada protocol**—a **clear, stable, and community-owned** synchronization specification—and advance the **Nagada-Pulse implementation model** that enables offline-first, deterministic convergence across devices.

### Core Values

- 🎯 **Clarity** – Specification-first; behavior defined, not inferred
- 🤝 **Collaboration** – Community-driven; everyone's voice matters
- 🔒 **Stability** – Once 1.0, breaking changes require major versions
- 🌍 **Openness** – Apache-2.0 licensed; transparent decision-making
- 🛡️ **Integrity** – Protocol changes require consensus; no unilateral decisions

---

## Project Structure

### Roles and Responsibilities

#### **Maintainers**

**Who:** Core team stewarding the Nagada protocol specification and Nagada-Pulse implementation model

**Responsibilities:**
- Review and merge PRs to specification documents
- Facilitate discussions on protocol changes
- Release new versions following semantic versioning
- Enforce code of conduct
- Manage roadmap priorities

**How to become:** Demonstrated consistent contributions for 6+ months + team consensus

#### **Contributors**

**Who:** Anyone proposing changes or improvements

**Responsibilities:**
- Follow CONTRIBUTING.md guidelines
- Provide clear rationale for changes
- Participate in discussions constructively
- Acknowledge feedback and iterate

**Recognition:** Listed in CHANGELOG.md for each release

#### **Community Members**

**Who:** Users, implementers, and stakeholders

**Responsibilities:**
- Use the protocol responsibly
- Report issues and suggest improvements
- Share feedback in discussions
- Help others in community forums

**Recognition:** Highlighted in project announcements

---

## Decision-Making Process

### Specification Changes

All changes to protocol specification follow this process:

#### 1. **Proposal Phase** (1-2 weeks)

- Open a **Discussion** in `.github/discussions/`
- Clearly state problem and proposed solution
- Include use cases and examples
- Link to related issues

#### 2. **Review Phase** (1-2 weeks)

- Maintainers provide initial feedback
- Community discusses implications
- Clarify requirements and trade-offs
- Identify potential conflicts

#### 3. **Design Phase** (1-4 weeks)

- Author drafts detailed specification change
- Includes wire format, client/server behavior, testing
- Creates example implementations or pseudocode
- Addresses backward compatibility

#### 4. **Consensus Phase** (1-2 weeks)

- Request feedback: "Ready for consensus?"
- Maintainers vote: ✅ Approve or 🔄 Request changes
- Majority approval (>50% maintainers) = Accepted
- Document decisions in meeting notes

#### 5. **Merge Phase**

- Create PR with specification changes
- Code review for clarity and consistency
- Merge when approved
- Release in next version

### Expedited Process for Minor Changes

**Typos, clarifications, and non-breaking improvements:** 1-week comment period before merge.

---

## Versioning and Stability

### Semantic Versioning

```
MAJOR.MINOR.PATCH
 v0.1.0 → v0.2.0 → v1.0.0
```

### Pre-1.0 (0.x versions)

- **Stability:** Experimental; breaking changes allowed
- **Cadence:** 2-3 months per release
- **Process:** 1-week review minimum

### v1.0 and Beyond

- **Stability:** Stable; breaking changes only in major versions
- **Cadence:** 6-12 months per release
- **Process:** 2-week review minimum; consensus required for major changes

### Backward Compatibility

From v1.0 onward, all versions MUST:

- ✅ Support events from previous versions
- ✅ Maintain wire format compatibility
- ✅ Allow graceful degradation of new features
- ✅ Document any deprecations

---

## Extension Management

### Extension Lifecycle

**Proposal** → **Experimental (v0.x)** → **Stable (v1.0+)** → **Deprecated/Archived**

### Extension Governance

1. **Extensions are optional** – Nagada core protocol remains unchanged
2. **Extensions can be versioned independently** – Not tied to Nagada release cycle
3. **Extensions must pass conformance tests** – If offered as "Nagada-compatible" or "Nagada-Pulse compatible"
4. **Extensions can be deprecated** – With 1-2 version notice

### Current Extensions (Roadmap)

See `/extensions/` and `roadmap.md` for:
- WebSocket Transport (v0.7)
- CRDT Payload Support (v0.8)
- Snapshotting Strategy (v0.8)

---

## Conflict Resolution

### Dispute Process

**If you disagree with a decision:**

1. **Discuss openly** – Comment on PR/issue with concerns
2. **Request re-review** – Ask maintainers to reconsider
3. **Escalate to discussion** – Raise in `.github/discussions/`
4. **Request mediation** – If still unresolved, ask a maintainer to mediate

### Maintainer Mediation

- Neutral third-party review
- Both sides heard equally
- Decision documented publicly
- Appeal process available

### Appeal Process

If you believe a decision violates project values:

1. Email: **governance@nagada.example.com**
2. Include: Concern, context, proposed resolution
3. Response: Within 5 business days
4. Decision: Final (can be revisited after new information surfaces)

---

## Code of Conduct

### Expected Behavior

The Nagada community is **respectful, inclusive, and welcoming**.

We expect:
- ✅ Respectful disagreement
- ✅ Good-faith engagement
- ✅ Assumption of positive intent
- ✅ Acknowledgment of different perspectives

### Unacceptable Behavior

We do not tolerate:
- ❌ Harassment, discrimination, or hate speech
- ❌ Personal attacks or insults
- ❌ Threats or intimidation
- ❌ Doxxing or privacy violations
- ❌ Spam or off-topic derailing

### Enforcement

**Minor violations:** Warning + request for behavior change  
**Major violations:** Temporary mute or ban from discussions  
**Severe violations:** Permanent removal from project

**Report violations:** conduct@nagada.example.com (confidential)

---

## Intellectual Property

### Contributions

By contributing to Nagada, you:

- ✅ Grant project rights to use your contribution
- ✅ Affirm you own or have rights to the contribution
- ✅ Agree contribution is licensed under Apache 2.0

### Attribution

Contributors are:

- ✅ Named in CHANGELOG.md for each release
- ✅ Credited in specification documents (major contributions)
- ✅ Listed in project website contributors section

---

## Meetings and Communication

### Regular Communications

- **Discussions:** `.github/discussions/` (asynchronous, preferred)
- **Issues:** Bugs and feature requests
- **Announcements:** CHANGELOG.md, project website
- **Email:** For private concerns (conduct, IP, etc.)

### Maintainer Meetings

- **Frequency:** Monthly (first Tuesday)
- **Agenda:** Shared 3 days prior
- **Notes:** Public summary published
- **Observers:** Community welcome to attend

**Calendar:** TBA on project website

---

## Project Sustainability

### Long-term Vision

The **Nagada protocol** aims to become a **community-governed standard** like:

- HTTP (IETF)
- MQTT (OASIS)
- JSON-RPC (Public specification)

The **Nagada-Pulse implementation model** demonstrates the protocol in practice.

This vision means:

1. **Multiple implementations** – Different languages and platforms (not just Nagada-Pulse)
2. **Decentralized development** – Not dependent on single company
3. **Formal standardization** – Eventually move to neutral body
4. **Sustainable funding** – Community contributions + sponsorships

### Current Sustainability

The project is sustained by:

- 🤝 Volunteer contributions
- 💰 Community sponsorships (if available)
- 🏢 Organizational support (if available)

**Donations:** See README.md

---

## Feedback on Governance

Have ideas for improving how we govern Nagada?

**Open a Discussion:** `.github/discussions/`  
**Tag:** `governance`

We take governance feedback seriously and iterate continuously.

---

## Contact and Resources

| Purpose | Contact |
|---------|---------|  
| General questions | hello@nagada-pulse.example.com |
| Governance matters | governance@nagada-pulse.example.com |
| Code of conduct | conduct@nagada-pulse.example.com |
| Security issues | security@nagada-pulse.example.com |
| Brand and trademarks | branding@nagada-pulse.example.com |**GitHub Discussions:** `.github/discussions/`  
**Contributing Guide:** `CONTRIBUTING.md`  
**Roadmap:** `roadmap.md`
