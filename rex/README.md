# Rex

`init.lua` and the `copy-mode*.lua` modules are linked to
`${XDG_CONFIG_HOME:-$HOME/.config}/rex/` by `install.sh`. Reload the config on
the Rex server with `rex config reload`.

* `Ctrl+B`, then `v` or `|`: split to the right (`|` is Option+7 on a German Mac keyboard).
* `Ctrl+B`, then `-`: split below.
* `Ctrl+B`, then an arrow: focus a neighboring pane.
* `Ctrl+B`, then `z`: zoom or unzoom a pane.
* `Ctrl+B`, then `y`: open Vim-style copy mode ([rex-copy-mode](https://github.com/CJNE/rex-copy-mode), requires `nvim`; select with `v`/`V`/`Ctrl+V`, `Enter` copies and returns, `y` copies without closing, `:q` cancels).
* `Ctrl+B`, then `P`: paste clipboard into the focused pane.
* `Ctrl+B`, then `Ctrl+B`: send Ctrl+B to the terminal, e.g. for nested tmux.

The `|` binding targets the German macOS keyboard layout. Other keyboard
layouts can change `ctrl+b>alt+7` in `init.lua` to their unshifted key and
modifiers; `v` works independently.

The macOS app stores appearance separately from the Rex server Lua config.
In Rex Beta's Settings, select **JetBrainsMono Nerd Font** at **20 pt**.
Import `rex/Catppuccin Mocha` under **Themes > Import Theme**, then select it
for dark mode. This theme is the palette bundled with Ghostty. Ghostty's
8 px window padding has no equivalent configured here.
