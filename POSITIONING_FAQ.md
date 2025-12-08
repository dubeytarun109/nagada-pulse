# Nagada vs Nagada-Pulse: Positioning FAQ

**Last Updated:** 2025-12-08

---

## Quick Distinction

| Aspect | Nagada | Nagada-Pulse |
|--------|--------|--------------|
| **What it is** | Protocol Specification | Implementation Model |
| **Defines** | Sync algorithm & wire format | Heartbeat-based realtime model |
| **Level** | Standard (like HTTP) | Reference (like Apache) |
| **Scope** | Offline-first convergence | Event sourcing + heartbeat |
| **Use** | Implement in any language | Follow this pattern |
| **Govern** | Community standard | Open-source project |

---

## The Analogy

### HTTP vs Apache HTTP Server

```
HTTP                          Apache HTTP Server
├─ Internet protocol          ├─ Implements HTTP
├─ Used everywhere            ├─ One implementation
├─ Defined by IETF            ├─ Open-source project
└─ Independent of any product └─ Reference for others
```

### Nagada vs Nagada-Pulse

```
Nagada                        Nagada-Pulse
├─ Sync protocol standard     ├─ Implements Nagada
├─ Multi-implementable        ├─ One reference implementation
├─ Community-governed         ├─ Open-source project
└─ Language/platform agnostic └─ Reference pattern for others
```

---

## Frequently Asked Questions

### Understanding the Relationship

**Q: Is Nagada just another name for Nagada-Pulse?**

A: No. **Nagada** is the protocol specification; **Nagada-Pulse** is one implementation of it. Think of Nagada as the blueprint and Nagada-Pulse as the house built from that blueprint.

**Q: Which should I use?**

A: It depends:
- **Use Nagada if:** You want to implement sync in your own way or with your own architecture
- **Use Nagada-Pulse if:** You want a ready-made heartbeat model to reference or build on

**Q: Do I have to use Nagada-Pulse to use Nagada?**

A: No. Nagada is independent of Nagada-Pulse. You can implement Nagada following the spec without touching Nagada-Pulse code.

---

### For Protocol Users

**Q: I'm building a sync system. Should I implement Nagada or Nagada-Pulse?**

A: You should **implement Nagada**. Nagada-Pulse is the reference implementation we provide—you can fork it, study it, or build your own from the Nagada spec.

**Q: Can I just use Nagada-Pulse as-is?**

A: Yes! Nagada-Pulse is production-ready (at its current version). You can use it directly or customize it for your needs.

**Q: What if Nagada-Pulse doesn't meet my needs?**

A: Implement your own version of Nagada. The spec defines the contract; the implementation is up to you. You could:
- Fork Nagada-Pulse and modify it
- Implement Nagada from scratch in your language
- Use a different Nagada implementation from the community
- Contribute improvements back to Nagada-Pulse

---

### For Implementers & Contributors

**Q: I want to create a Nagada implementation. Do I need permission?**

A: No. Nagada is an open standard under Apache 2.0. Anyone can implement it. For **naming** and **branding**, see TRADEMARK_POLICY.md.

**Q: I want to contribute to Nagada-Pulse. How do I start?**

A: See CONTRIBUTING.md for the process. Nagada-Pulse is the reference implementation, so contributions help all Nagada users.

**Q: I want to propose changes to the Nagada protocol. How?**

A: Open a Discussion in GitHub (`.github/discussions/`). Protocol changes follow a formal decision process. See GOVERNANCE.md.

**Q: Can Nagada-Pulse have features that the Nagada spec doesn't require?**

A: Yes. Nagada-Pulse can implement optional extensions or add non-standard features. However, the core implementation must follow the Nagada spec exactly.

---

### For Architecture & Design

**Q: What defines Nagada?**

A: The Nagada specification (`/spec/` directory) defines:
- Protocol requirements
- Wire format (JSON schema)
- Client/server behavior
- Conflict resolution strategies
- Conformance tests

**Q: What defines Nagada-Pulse?**

A: Nagada-Pulse adds:
- Heartbeat model (systole/diastole rhythm)
- Event sourcing architecture
- Server-side event store design
- Specific conflict resolution implementations
- Reference code and examples

**Q: Can I implement a different sync rhythm (not heartbeat)?**

A: If it still follows Nagada's protocol requirements, yes. You'd be implementing an alternative model while remaining Nagada-compatible. You couldn't call it "Nagada-Pulse" (that's our trademark), but you could say:

"**Nagada Protocol** with **Custom Polling Model**"

---

### For Projects & Products

**Q: Should I call my project 'Nagada' or 'Nagada-Pulse'?**

A: Use the appropriate one:
- **"Nagada [Language]"** – If implementing the protocol independently
  - Examples: "Nagada-Dart", "Nagada-Go", "Nagada-Python"
  - Signal: Generic protocol implementation
  
- **"[Your Project] using Nagada"** – If building with the protocol
  - Examples: "MyApp using Nagada", "MyService powered by Nagada"
  - Signal: Using the standard

- **"Nagada-Pulse-based"** – If forking/extending Nagada-Pulse
  - Examples: "Nagada-Pulse with CRDTs", "Nagada-Pulse for Kubernetes"
  - Signal: Based on reference implementation

For commercial products, request approval. See TRADEMARK_POLICY.md.

**Q: Can I say my product is "Nagada-compatible"?**

A: Yes, if it passes conformance tests. See spec/09-conformance-tests.md.

---

### For Standards & Governance

**Q: Will Nagada eventually move to a standards body?**

A: That's the long-term vision. Like HTTP moved to IETF, Nagada could eventually be governed by a neutral standards body (IETF, OASIS, etc.). Nagada-Pulse would remain the reference implementation.

**Q: Who governs Nagada vs Nagada-Pulse?**

A: Both are governed by the Nagada-Pulse Project community, but differently:
- **Nagada protocol** – Consensus-based (all stakeholders)
- **Nagada-Pulse implementation** – Maintainer-led with community input

See GOVERNANCE.md.

**Q: Can Nagada change without Nagada-Pulse changing?**

A: Yes. If the Nagada spec changes, Nagada-Pulse must be updated to comply. But Nagada-Pulse could stay on an older spec version if needed for stability.

**Q: Can Nagada-Pulse change without Nagada changing?**

A: Yes. Nagada-Pulse can add features, optimizations, or extensions that don't change the core protocol.

---

### For Learning & Documentation

**Q: Where do I learn about Nagada?**

A: Start with:
1. `/spec/` – Protocol specification
2. `roadmap.md` – Vision and milestones
3. `GOVERNANCE.md` – How it's governed
4. `spec/09-conformance-tests.md` – What "Nagada-compatible" means

**Q: Where do I learn about Nagada-Pulse?**

A: Start with:
1. `/server/README.md` – Server implementation
2. `/client/README.md` – Client implementation
3. `/examples/` – Working code samples
4. `spec/03-protocol-overview.md` – Heartbeat model details

**Q: How are they documented?**

A: They're documented together but distinctly:
- **Nagada docs** – "The protocol says..."
- **Nagada-Pulse docs** – "We implement this by..."

---

### For Versions & Releases

**Q: How are Nagada and Nagada-Pulse versioned?**

A: **Independently**:
- **Nagada** – Semantic versioning (v0.1.0 → v1.0.0)
- **Nagada-Pulse** – Semantic versioning (follows Nagada version for core alignment)

**Q: Can Nagada v1.0 exist without Nagada-Pulse v1.0?**

A: Yes. Nagada might reach v1.0 (stable protocol) while Nagada-Pulse is still at v0.x (experimental implementation).

**Q: Are breaking changes handled the same?**

A: No:
- **Nagada breaking changes** – Require community consensus
- **Nagada-Pulse breaking changes** – Maintainer team decides (with input)

---

### For Support & Help

**Q: My Nagada implementation has a bug. Who helps?**

A: It depends on where the bug is:
- **In the Nagada spec** – Report to GitHub Issues; we clarify the spec
- **In your Nagada-Pulse fork** – Fix it yourself; it's your responsibility
- **In reference Nagada-Pulse** – Report to GitHub Issues; we fix it

**Q: Nagada-Pulse doesn't have feature X. Do I report it?**

A: Yes:
- If **feature X is in the spec** – We should implement it; file an issue
- If **feature X is not in spec** – Propose it as an enhancement; we'll discuss

**Q: Is there Nagada-Pulse support?**

A: Community-supported, not commercial. See README.md for support options.

---

### For Future Compatibility

**Q: If I implement Nagada now, will it work with future versions?**

A: Yes, with considerations:
- **Nagada v0.x** – Breaking changes possible; plan for upgrades
- **Nagada v1.0+** – Breaking changes only in major versions; backward compatibility guaranteed
- **Nagada-Pulse changes** – Don't affect your Nagada implementation unless you explicitly update

**Q: Should I pin my Nagada implementation to a specific version?**

A: Yes:
- For v0.x – Pin to minor versions (e.g., v0.2.x, v0.3.x)
- For v1.0+ – Safe to use latest patch version

**Q: What if I need both Nagada and Nagada-Pulse?**

A: You can:
- Implement Nagada as your sync protocol
- Use Nagada-Pulse as your server
- Mix and match components as needed

---

## Visual Reference

### Nagada Ecosystem

```
Nagada Protocol Spec
│
├─ Nagada-Pulse (Official Reference)
│  ├─ Dart Server
│  ├─ TypeScript Client
│  └─ Example Apps
│
├─ Community Implementations
│  ├─ Nagada-Go (Alternative server)
│  ├─ Nagada-Python (Alternative client)
│  └─ Nagada-Java (Enterprise variant)
│
└─ Powered Projects
   ├─ MyApp (using Nagada)
   ├─ OurService (Nagada-Pulse fork)
   └─ TheirDB (Nagada-compatible)
```

### Decision Tree

```
Do you want to sync data offline-first?
│
├─ Yes → Do you want a reference implementation?
│        ├─ Yes → Use Nagada-Pulse
│        └─ No → Implement Nagada yourself
│
└─ No → This might not be for you
```

---

## Key Takeaways

1. **Nagada = Standard** – Anyone can implement it
2. **Nagada-Pulse = Reference** – One official implementation
3. **Independent but aligned** – Nagada-Pulse implements Nagada
4. **Community-driven** – Both are open-source and governed together
5. **Your choice** – Use one, both, or neither (implement your own)

---

## Contact

**Nagada Protocol Questions:** hello@nagada-pulse.example.com  
**Nagada-Pulse Implementation Questions:** dev@nagada-pulse.example.com  
**Positioning & Branding:** branding@nagada-pulse.example.com  
**Clarification Needed?** Open a Discussion: `.github/discussions/`

---

## Related Documentation

- **TRADEMARK_POLICY.md** – Trademark usage and naming guidelines
- **BRAND_GUIDELINES.md** – Brand identity and communication
- **GOVERNANCE.md** – How decisions are made
- **LICENSE_FAQ.md** – Licensing for both Nagada and Nagada-Pulse
- **spec/00-index.md** – Full specification documentation
- **roadmap.md** – Vision and milestones for both
