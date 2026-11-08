---
description: "Rails and Ruby conventions for models, controllers, migrations, shared game logic, and tests."
applyTo: "app/**/*.rb,config/**/*.rb,db/**/*.rb,lib/**/*.rb,test/**/*.rb"
---

# Rails and Ruby

- Preserve intentional defaults and behavior from the CLI when evolving the web application. Do not substitute framework defaults for product decisions.
- Reuse the existing board and computer strategies; keep shared game rules independent of HTTP and Active Record.
- Validate submitted moves on the server. Persist human/computer turns atomically and reject stale submissions.
- Keep migrations additive and reversible where possible. Never drop or reset a database to make verification pass; disclose irreversible changes.
- Use absolute I18n keys for model messages and genuinely shared translations. Template-relative lookup belongs in views and partials.
- In controller tests, inherit from `ControllerTest` and prefer accessible Capybara selectors. Where those are insufficient, use literal dashed `data-test-id` hooks, not styling selectors or `data-test-class`; see the [controller assertion guidance](../initiatives/rails-view-composition/composition-guide.md#controller-assertions-and-data-hooks).
- Follow the repository's [code-quality skill](../skills/code-quality/SKILL.md) for responsibilities and class/test organization, and the [verification policy](../copilot-instructions.md#verification) for checks.
