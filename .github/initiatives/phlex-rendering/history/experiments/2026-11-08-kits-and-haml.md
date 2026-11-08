# 2026-11-08 Kits and Haml

- **Type:** investigation
- **Status:** succeeded
- **Question or problem:** Can Kit setup and helper inclusion replace manual rendering with `ErrorMessage(message: ...)` in the existing Haml views?
- **Hypothesis:** The previous project's `Components` Kit and `ApplicationHelper` inclusion might provide the desired syntax here.
- **Approach:** Inspect application configuration and component call sites, then consult online Phlex documentation. Installed gem-source inspection was interrupted and abandoned at the user's request.
- **Evaluation criteria:** Distinguish documented behavior from inferred compatibility and identify the rendering-context and namespace requirements.

## Evidence

- [Gemfile](../../../../../Gemfile) declares Phlex `~> 1.10` and phlex-rails `~> 0.0`. `bundle show phlex` and `bundle show phlex-rails` identified installed versions 1.11.1 and 0.1.0.
- [ApplicationHelper](../../../../../app/helpers/application_helper.rb) is empty.
- [ErrorMessage](../../../../../app/components/design_system/error_message.rb) lives under `DesignSystem`, with a [base](../../../../../app/components/design_system/base.rb) inheriting from `Phlex::HTML`.
- [Index](../../../../../app/views/matches/index.html.haml) and [show](../../../../../app/views/matches/show.html.haml) use `raw(DesignSystem::ErrorMessage.new(...).call)`. The index also manually renders components under `Matches`.
- [Kits documentation](https://www.phlex.fun/components/kits.html): extend `Phlex::Kit`, then include the Kit in a Phlex component for unqualified calls. Its final warning states: "Kits only work from a Phlex context." It explicitly excludes ERB.
- [Rendering documentation](https://www.phlex.fun/components/rendering): `call` is an outside-rendering interface normally handled by framework integrations. Rails controller `render` supplies a view context.
- [Rails views documentation](https://www.phlex.fun/rails/views): Phlex views are components rendered from controllers.
- [Rails helpers documentation](https://www.phlex.fun/rails/helpers): Rails helpers in Phlex use adapters. This is the reverse direction from calling Phlex in Haml.

## Findings

1. Kits are not missing from Phlex itself. The documented shorthand requires both a Kit namespace and a Phlex caller.
2. Haml is not a Phlex rendering context. The docs do not establish that `include Components` in `ApplicationHelper` supplies a Haml bridge.
3. Defining `Components` alone would not register classes under the existing top-level `DesignSystem` namespace. Unqualified `ErrorMessage` needs an appropriate namespace inclusion or an explicit helper.
4. Manual `call` output can work without proving that Rails integration is configured correctly. The historical plan's successful raw rendering does not prove native Kit support.
5. Installed-version compatibility and alternative Haml rendering syntax remain untested. Current documentation is not sufficient evidence to authorize a gem upgrade.

## Conclusion

Do not prescribe the previous project's setup as a drop-in Haml fix. Native Kits require a Phlex caller. Keeping Haml would require verifying normal Rails component rendering, or introducing an explicit helper for the exact capitalized API.

## Implications and follow-up

Agree on the rendering context before application changes. Preserve the old plan as history; update current design-system guidance after the chosen integration is verified. No application tests or browser checks were run during this documentation investigation.

The user chose to stop at the documented findings. Implementation is deferred.

## Related decisions

None accepted yet.
