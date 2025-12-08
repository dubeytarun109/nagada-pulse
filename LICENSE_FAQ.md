# Nagada License and Licensing FAQ

**Last Updated:** 2025-12-08

---

## Quick Answer

**Q: What license is the Nagada protocol under?**

A: **Apache License 2.0** (Apache-2.0)

**Q: Is it free to use?**

A: **Yes, completely free** for any purpose—commercial or non-commercial.

**Q: Do I have to open-source my Nagada or Nagada-Pulse implementation?**

A: **No**. You can use Nagada in closed-source, proprietary, or commercial products.

---

## License Overview

### Apache License 2.0

The **Nagada Sync Protocol Specification** and **Nagada-Pulse Implementation Model** are licensed under **Apache License 2.0**.

**Key Points:**

- ✅ Free to use, modify, and distribute
- ✅ Can be used in commercial products
- ✅ No copyleft requirement (closed-source OK)
- ✅ Must include license notice and state changes
- ✅ Limited liability; provided "as-is"

**Full License:** See `LICENSE` file in repository

---

## What You Can Do

### ✅ You May

- ✅ **Use the Nagada protocol** in commercial products
- ✅ **Implement Nagada** in any language
- ✅ **Use the Nagada-Pulse model** as reference
- ✅ **Modify the specification** for your needs
- ✅ **Distribute** implementations (open or closed source)
- ✅ **Sell software** using Nagada or Nagada-Pulse
- ✅ **Patent implementations** (if you choose)
- ✅ **Use in proprietary products** without disclosure
- ✅ **Combine with other licenses** (e.g., GPL, MIT)

### Example Use Cases

**Commercial SaaS using Nagada:** ✅ Allowed  
**Proprietary Mobile App with Nagada-Pulse:** ✅ Allowed  
**Closed-source Enterprise Software:** ✅ Allowed  
**Open-source Nagada Implementation:** ✅ Allowed  
**Alternative Nagada Implementation Model:** ✅ Allowed  

---

## What You Must Do

### ⚠️ Required

To use Nagada, you **must**:

1. **Include the License**
   - Include a copy of Apache License 2.0
   - Include notice of any modifications
   - State the location of original source

2. **Provide Attribution**
   - Credit the Nagada-Pulse Project
   - Reference `https://github.com/nagada-pulse/nagada`
   - Indicate whether you're using Nagada protocol, Nagada-Pulse model, or both

3. **Document Changes** (if you modify the spec)
   - Clearly indicate what you changed
   - Keep original copyright notices

### Example Attribution

```
This software implements the Nagada Sync Protocol
using the Nagada-Pulse heartbeat model.

Specification: https://github.com/nagada-pulse/nagada
Licensed under Apache License 2.0
(c) 2025 Nagada-Pulse Project

Modifications:
- [Describe your changes]
```

---

## What You Cannot Do

### ❌ Prohibited

- ❌ **Remove license or attribution**
- ❌ **Claim the specification as your own**
- ❌ **Use "Nagada" trademark without permission** (see TRADEMARK_POLICY.md)
- ❌ **Hold licensor liable** (see liability clause below)
- ❌ **Claim warranty** that doesn't exist (see disclaimer below)

---

## Key Terms Explained

### Modifications

If you modify or extend the Nagada specification, you must:

- Document what you changed
- Keep original license notice
- Describe the modifications

**Examples of modifications:**
- Adding optional new fields to wire format
- Creating extensions (e.g., WebSocket transport)
- Clarifications or interpretations

**Examples NOT requiring notice:**
- Implementing the specification as-is
- Using the specification to build software

### Distribution

If you distribute the specification or implementations:

- Include Apache License 2.0
- Include copyright notices
- Describe any modifications
- Provide source code availability info

### Patent Grant

Nagada grants you a perpetual patent license to:

- Make, have made, use, offer to sell, sell, import
- Contribute to products that use the protocol

The license terminates if you sue for patent infringement.

---

## Liability and Warranty

### Disclaimer

**THE SPECIFICATION IS PROVIDED "AS-IS" WITHOUT WARRANTY OR GUARANTEE**

The Nagada Project disclaims:
- ❌ Fitness for particular purpose
- ❌ Non-infringement of third-party rights
- ❌ Merchantability
- ❌ Any performance guarantees

### Limitation of Liability

**The Nagada Project is NOT liable for:**
- ❌ Data loss or corruption
- ❌ Business losses
- ❌ Indirect or consequential damages
- ❌ Any other damages, even if advised of possibility

**Exception:** Nothing in this license limits liability for gross negligence or willful misconduct.

---

## FAQ

### Commercial Use

**Q: Can I use Nagada or Nagada-Pulse in a commercial product?**

A: ✅ **Yes, completely free.** No royalties, no licensing fees, no restrictions.

**Q: Do I have to pay the Nagada Project?**

A: ❌ **No.** The license is free forever. Optional donations welcome but never required.

**Q: Can I charge my customers for using Nagada?**

A: ✅ **Yes.** You own your product; price it however you want.

### Modifications and Extensions

**Q: Can I modify the specification?**

A: ✅ **Yes,** but you must document changes and include the license notice.

**Q: Can I create my own protocol variant?**

A: ✅ **Yes,** but if you call it "Nagada," it must be compatible with the spec. See TRADEMARK_POLICY.md.

**Q: Can I propose extensions?**

A: ✅ **Yes,** through GitHub issues and discussions.

### Open Source Requirements

**Q: Must I open-source my implementation?**

A: ❌ **No.** The Nagada protocol has no copyleft requirement. You can keep implementations proprietary.

**Q: Do I have to contribute back to the project?**

A: ❌ **No.** Contributing is voluntary and appreciated but not required.

**Q: Can I use Nagada or Nagada-Pulse in a GPL project?**

A: ✅ **Yes.** Apache 2.0 is compatible with GPL 3.0. Check GPL 2.0 compatibility separately.

### Patent Issues

**Q: Will I be sued for patent infringement?**

A: The Apache License includes a patent grant. Contributors grant you patent rights. However:

- Nagada doesn't guarantee third-party patent safety
- See DISCLAIMER above
- Review your own patent concerns with counsel

**Q: Can I patent my Nagada or Nagada-Pulse implementation?**

A: ✅ **Yes.** You can patent your implementation or enhancements. The patent grant survives if you license it under Apache 2.0.

### Trademark and Branding

**Q: Can I use "Nagada" or "Nagada-Pulse" in my product name?**

A: See TRADEMARK_POLICY.md. Short answer: Community use OK; commercial products need approval.

**Q: Can I claim my implementation is "Nagada-compatible" or "Nagada-Pulse compatible"?**

A: ✅ **Yes, if it passes conformance tests.** See spec/09-conformance-tests.md.

**Q: Can I say I'm "endorsed by Nagada"?**

A: ❌ **No, unless you have written permission.** Implicit endorsement claims are not allowed.

### Different Versions

**Q: Does the license change between protocol versions?**

A: Unlikely, but it may evolve. Changes will be announced in CHANGELOG.md.

**Q: What if I'm using v0.1 and don't want to upgrade?**

A: ✅ **You can keep using v0.1 indefinitely.** Old versions remain licensed under their original license.

---

## Compatibility with Other Licenses

### Compatible

| License | Compatibility | Note |
|---------|--------------|------|
| GPL 3.0 | ✅ Yes | Fully compatible |
| MIT | ✅ Yes | Fully compatible |
| BSD | ✅ Yes | Fully compatible |
| MPL 2.0 | ✅ Yes | Fully compatible |
| Apache 2.0 | ✅ Yes | Identical |

### Conditional

| License | Compatibility | Note |
|---------|--------------|------|
| GPL 2.0 | ⚠️ Check | Requires review; depends on terms |
| AGPL 3.0 | ⚠️ Check | Requires review; network effects |

### Incompatible

| License | Compatibility | Note |
|---------|--------------|------|
| SSPL | ❌ No | Contains conflicting terms |

**Always review with legal counsel if unsure.**

---

## Contributing Code/Specifications

### Contributor License Agreement

By submitting a pull request, you agree that:

1. You own or have rights to the contribution
2. You license it under Apache License 2.0
3. The project may use and modify your contribution

**No separate CLA required** — your PR itself is your agreement.

### Copyright Attribution

- Your contribution retains your copyright
- Project gains right to use under Apache 2.0
- You're credited in CHANGELOG.md

---

## Contact

**Licensing Questions:** legal@nagada-pulse.example.com  
**Patent Concerns:** legal@nagada-pulse.example.com  
**Trademark Usage:** branding@nagada-pulse.example.com  

---

## References

- **Apache License 2.0:** https://www.apache.org/licenses/LICENSE-2.0
- **TRADEMARK_POLICY.md:** See project root
- **CONTRIBUTING.md:** See project root
- **LICENSE file:** See project root

---

## Disclaimer

**This FAQ is provided for informational purposes only and is not legal advice.**

For specific legal concerns, please consult a qualified attorney familiar with open-source licensing and your jurisdiction.

The Nagada Project is not liable for reliance on this FAQ.
