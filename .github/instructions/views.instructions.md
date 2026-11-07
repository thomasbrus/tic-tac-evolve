---
description: "Haml, Tailwind CSS 4, Hotwire, and relative Rails translations for views, frontend assets, and locales."
applyTo: "app/views/**,app/assets/**,app/javascript/**,config/locales/**/*.yml"
---

# Rails Frontend

- Use Haml for application HTML views, Tailwind CSS 4 for styling, and the existing Hotwire/importmap stack. Preserve intentional UI defaults and interaction behavior.
- Prefer Tailwind utilities and shared theme tokens over parallel handwritten component styles. Keep conditional utility names complete so the compiler can discover them.
- Use `t(".key")` for template- and partial-specific text, with locale keys matching the template path. Keep absolute keys for genuinely shared labels; check other consumers before moving a key.
- Translate complete accessible labels using interpolation, not concatenated translated fragments. Preserve labels, focus behavior, and keyboard access when editing markup.
- Preserve Haml indentation and block structure, especially around Ruby conditionals and form helpers. Verify rendering with focused request tests.
- Follow the [verification policy](../copilot-instructions.md#verification); browser checks require agreed scenarios and must not run when deferred.
