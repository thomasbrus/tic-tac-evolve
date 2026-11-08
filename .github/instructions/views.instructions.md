---
description: "Haml, Tailwind CSS 4, Hotwire, and relative Rails translations for views, frontend assets, and locales."
applyTo: "app/views/**,app/assets/**,app/javascript/**,config/locales/**/*.yml"
---

# Rails Frontend

- Use Haml for application HTML views, Tailwind CSS 4 for styling, and the existing Hotwire/importmap stack. Preserve intentional UI defaults and interaction behavior.
- Compose feature pages in Haml. Extract useful or repeated fragments into partials with strict locals, and keep page flow in the view. Start every partial with `-# locals: (match:)` (declare its actual inputs), or `-# locals: ()` when it accepts none.
- Use single quotes for Ruby strings unless interpolation or escapes require double quotes. HTML-style Haml attributes may use double quotes.
- Use parentheses for Ruby calls with arguments, including Rails helpers: `render('history_heading', page: @page)`.
- Write classes in shorthand when all names support it: `%section.border-b.border-line.pt-6`. Otherwise use `%section(class="...")`, including interpolated strings. Use `{ class: ... }` only when HTML-style attributes cannot express the value, such as a class array or hash. Preserve complete Tailwind names; never put dots, colons, brackets, or slashes into class shorthand.
- Use shared components for recurring appearance and semantics; keep placement and layout at the call site. Let Rails form helpers own form submission behavior.
- Keep view helpers limited to presentation formatting. Do not put queries, game rules, or mutations in them.
- Prefer Tailwind utilities and shared theme tokens over parallel handwritten component styles. Keep conditional utility names complete so the compiler can discover them.
- Use `t('.key')` for template- and partial-specific text, with locale keys matching the template path. Keep absolute keys for genuinely shared labels; check other consumers before moving a key.
- Translate complete accessible labels using interpolation, not concatenated translated fragments. Preserve labels, focus behavior, and keyboard access when editing markup.
- Preserve Haml indentation and block structure, especially around Ruby conditionals and form helpers. Verify rendering with focused request tests.
- Run `bundle exec haml-lint` before finishing Haml or lint-configuration work. It includes RuboCop for embedded Ruby and strict-locals checks; review the full class fallback order manually because built-in linting covers only basic shorthand cases.
- Follow the [verification policy](../copilot-instructions.md#verification); browser checks require agreed scenarios and must not run when deferred.
