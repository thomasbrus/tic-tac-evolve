# 2026-11-08 View construction baseline

- **Type:** investigation
- **Status:** succeeded
- **Question:** Where do the current view boundaries diverge from Rails-native feature composition and shared UI reuse?
- **Hypothesis:** Small feature-specific wrappers can move to partials while shared primitives remain useful.
- **Approach:** Inspect both match templates, the layout, all five match components, representative shared primitives, the Kit initializer/helper, translations, and nearest tests. Interpret the supplied guide without reproducing it.
- **Evaluation criteria:** Ground the proposed first slice in current code; distinguish source observations from runtime or visual verification.

## Evidence and findings

| Observation | Source |
| --- | --- |
| Setup and history call five match-specific components; the form and list orchestration remain in Haml. | [Index view](../../../../../app/views/matches/index.html.haml) |
| Setup, history heading, and empty-state wrappers largely contain markup and repeated text styling. | [Setup](../../../../../app/components/matches/match_setup_section.rb), [history heading](../../../../../app/components/matches/match_history_section.rb), [empty state](../../../../../app/components/matches/match_history_empty_state.rb) |
| History item and pagination mix Rails route access, absolute translation lookup, and ordinary feature markup. | [History item](../../../../../app/components/matches/match_history_item.rb), [pagination](../../../../../app/components/matches/match_history_pagination.rb) |
| The history heading component closes its section before the list and pagination render. Extraction must inspect the intended landmark boundary; changing it is not automatically approved. | [History heading](../../../../../app/components/matches/match_history_section.rb), [index view](../../../../../app/views/matches/index.html.haml) |
| Play and layout templates repeat typography utilities. The board uses Rails `button_to` forms with position and revision parameters. | [Play view](../../../../../app/views/matches/show.html.haml), [layout](../../../../../app/views/layouts/application.html.haml) |
| Typography has a responsive display variant and forwards HTML attributes through Base. Heading has separate level/size/text parameters. They are not interchangeable APIs. | [Typography](../../../../../app/components/design_system/typography.rb), [Heading](../../../../../app/components/design_system/heading.rb), [Base](../../../../../app/components/design_system/base.rb) |
| Grouping directories are collapsed into the Components namespace, exposed through a Phlex Kit included in ApplicationHelper. No integration replacement is needed for this proposal. | [Initializer](../../../../../config/initializers/phlex.rb), [helper](../../../../../app/helpers/application_helper.rb) |
| A helper test directly renders MatchSetupSection, so deleting that wrapper requires replacing its integration coverage. Request tests cover history, pagination, labels, setup failures, completed games, and stale moves. | [Helper tests](../../../../../test/helpers/application_helper_test.rb), [request tests](../../../../../test/controllers/matches_controller_test.rb) |
| Existing typography/heading tests cover component-level variants; they do not establish that the proposed partial examples render through Haml. | [Typography tests](../../../../../test/components/design_system/typography_test.rb), [Heading tests](../../../../../test/components/design_system/heading_test.rb) |
| Template labels currently live under matches.index and matches.show. Partial extraction requires deliberate scope changes. | [Locales](../../../../../config/locales/en.yml) |

## Conclusion

The first migration can be a setup/history slice using partials and existing UI primitives. There is no source evidence that replacing Phlex, adding another component framework, or adopting a new CSS naming system would serve this goal.

The class/partial boundary remains a proposed direction. Source inspection does not establish rendered equivalence, visual parity, or passing tests.

## Verification and follow-up

- `git --no-pager status --short` was clean before creating these records.
- Documentation validation: `git --no-pager diff --check -- .github/initiatives` passed. A scoped ripgrep scan found no trailing whitespace or conflict markers in the new records. Relative links and writing were reviewed; editor diagnostics reported no errors for the index and all seven new documents. These documents have no YAML frontmatter.
- No application tests, Tailwind build, autoload check, or browser checks were run. Documentation-only validation is appropriate for this session.
- Next: review the [guide](../../composition-guide.md) and approve or revise the [plan](../../PLAN.md), then run baseline tests before migration.
- Related accepted work: [Phlex integration state](../../../phlex-rendering/STATE.md). This initiative does not supersede that integration.
