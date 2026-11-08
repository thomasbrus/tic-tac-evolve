---
description: "Resume or guide a persistent engineering initiative: explore, plan, execute, review, reorient, or check status."
name: "initiative"
argument-hint: "Optional natural-language request; leave blank to resume or check status"
agent: "agent"
---

Load and follow [the initiative workflow skill](../skills/initiative-workflow/SKILL.md) before acting. Treat the user's text after `/initiative` as an optional natural-language request; infer intent rather than requiring a fixed subcommand. If it is absent or ambiguous, reconstruct status and recommend a next step without beginning substantial implementation.

Use [the initiative index](../initiatives/README.md) to identify or create the relevant initiative. Read only the selected initiative's README, STATE, PLAN, and relevant referenced records. Follow repository-wide instructions as well. Preserve user changes and existing history.

Request: ${input:request:What would you like to do? Leave blank to resume or check status.}
