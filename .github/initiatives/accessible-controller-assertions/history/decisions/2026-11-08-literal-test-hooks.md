# 2026-11-08 Literal data hooks without naming helpers

- **Status:** accepted
- **Context:** The initial proposal used `test_id` and `test_class` based on Rails DOM identifiers, plus static-name handling. The user requested dashed names, pointed out that static names can be literals, and proposed removing the class helper.
- **Options considered:**
  - Keep record-derived naming with a different helper name to avoid Minitest discovery.
  - Remove both helpers and use literal `data-test-id` names only where accessible selectors are insufficient.
- **Decision:** The user selected literal hooks. Configure `Capybara.test_id = 'data-test-id'`; use dashed names and no `data-test-class` attributes. Parse `response.body` each time `page` is requested.
- **Rationale:** No current locator needs record-name generation. Literal hooks avoid unnecessary branches and Minitest's discovery of public `test_` methods. Accessible record-specific links already provide individual match identity.
- **Consequences:** Remove the temporary helper implementation and its tests. Repeated items may share a hook for counts and scoping. Migrate controller assertions together because Capybara defines its own `assert_select`. Keep style-contract checks in rendering tests.
- **Related experiments and evidence:** [Implementation record](../experiments/2026-11-08-controller-migration.md), [verification evidence](../../evidence/2026-11-08-implementation.md), [Capybara selectors](https://rubydoc.info/gems/capybara/Capybara/Selector), [Minitest discovery](https://docs.seattlerb.org/minitest/Minitest/Test.html#method-c-runnable_methods).
- **Supersedes:** The helper-based proposal in the initial plan; no earlier decision file exists.
