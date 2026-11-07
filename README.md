# Stratego

A small Stratego CLI. The game lives in Ruby. How to work on it lives in three skills. Talk to the person who owns the layer you want to steer.

## Run

Requires Ruby 3.2 or newer.

```sh
ruby stratego.rb
```

With no arguments, the CLI runs interactive setup on one open board. Each player places an army on that player's home rows. Pieces stay visible: player2's letter tokens are lowercase. Enter a square and a setup token. When both armies are placed, it prints the board and `setup complete`. Extra arguments are an error.

## Layout

| Path | Owns |
| --- | --- |
| [stratego.rb](stratego.rb) | Process entry. Calls `Stratego.start`. |
| [lib/stratego.rb](lib/stratego.rb) | Loads the composition root. |
| [lib/stratego/game.rb](lib/stratego/game.rb) | CLI composition. Delegates. Does not own board or army rules. |
| [lib/stratego/board.rb](lib/stratego/board.rb) | The shared open board: lakes and placed pieces. |
| [lib/stratego/army.rb](lib/stratego/army.rb) | Piece counts and setup tokens. |

The code is the source of truth for counts, tokens, lakes, and home rows. Do not keep a second copy in a skill or in this file.

## Who to talk to

Each skill changes only the layer under it. Skipping a level is the failure: a director does not rewrite a developer's diff, and a developer does not rewrite their own job description.

| Talk to | When | They change | They do not |
| --- | --- | --- | --- |
| [/stratego](.github/skills/stratego/SKILL.md) | You want the game to change. | Ruby under [lib/stratego](lib/stratego) | Edit a skill |
| [/stratego-skill](.github/skills/stratego-skill/SKILL.md) | The way of working is wrong, or a miss would happen again. | The stratego skill | Implement the feature, or train the trainer |
| [/stratego-skill-skill](.github/skills/stratego-skill-skill/SKILL.md) | The lead's judgment is wrong: routing, scope, level skipping, rules you did not ask for. | The stratego-skill skill | Edit the game or the maker's skill |

Invoke the skill with that slash command, or name the desk in the request. One request, one desk. If you asked the wrong person, they should say so and stop.

Examples:

- "Add a check that a lake cannot hold a piece." Talk to stratego.
- "You keep putting view rules in `game.rb`. The playbook should say not to." Talk to stratego-skill.
- "When I correct a method, stop encoding today's diff as a permanent rule." Talk to stratego-skill-skill.

To correct the practice lead, say that this layer is wrong. That is the only case where stratego-skill-skill edits its own file. Do not add a fourth skill.
