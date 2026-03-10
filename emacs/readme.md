
# Emacs Setup (Emacs 30+)

Custom Emacs configuration focused on C/C++ development with CMake, clangd, and tree-sitter.

## Quick Start

Run `C-h v user-init-file` to find your init file (~/.emacs), then add:
```elisp
;;; -*- lexical-binding: t; -*-
(load-file "/home/ola/Documents/dev/tools/emacs/init.el")
```

## Packages

Packages are auto-installed from MELPA, NonGNU ELPA, and GNU ELPA via `use-package`.

| Package             | Purpose                               |
|:--------------------|:--------------------------------------|
| treemacs            | Tree file explorer (F9)               |
| treemacs-projectile | Projectile integration for treemacs   |
| projectile          | Project management (C-c p)            |
| magit               | Git interface                         |
| company             | In-buffer completion                  |
| eglot               | LSP client (clangd for C/C++)         |
| clang-format        | C/C++ code formatting (C-c f)         |
| cmake-mode          | CMake syntax support                  |
| multiple-cursors    | Edit multiple lines/matches at once   |
| which-key           | Keybinding discovery popups           |
| flyspell            | Spell checking (aspell)               |
| markdown-mode       | Markdown editing (pandoc)             |
| org / org-modern    | Notes, literate programming, planning |
| zenburn-theme       | Color theme                           |
| claude-code         | Claude Code integration (C-c c)       |
| claude-code-ide     | Claude Code IDE tools (C-c C-')       |
| monet               | Monet utilities                       |

## Theme

Using [zenburn](https://github.com/bbatsov/zenburn-emacs). Alternatives:
- [emacsthemes.com](https://emacsthemes.com/popular)
- [catppuccin](https://github.com/catppuccin/emacs)
- [solarized-emacs](https://github.com/bbatsov/solarized-emacs)

## C/C++ Development

### LSP (eglot + clangd)

Eglot is configured with clangd and the following flags:
- `--background-index` — index project in background
- `--clang-tidy` — enable clang-tidy diagnostics
- `--completion-style=detailed` — detailed completion items
- `--header-insertion=iwyu` — include-what-you-use header insertion

Eglot starts automatically when opening C/C++ files.

### Tree-sitter

When tree-sitter grammars are available (Emacs 29+), C/C++ files automatically use `c-ts-mode` / `c++-ts-mode` for improved syntax highlighting and indentation.

Install grammars: `M-x treesit-install-language-grammar` (select `c` and `cpp`).

Or via your system package manager:
```
pacman -Syu tree-sitter
```

### Code formatting

`clang-format` is bound to `C-c f` in C/C++ buffers. Place a `.clang-format` file in your project root to configure style.

### `.h` files

Header files (`.h`) are treated as C++ by default.

### Style

- Indent: 4 spaces
- Substatement braces at column 0

### CMake Build

Two interactive commands read presets from `CMakePresets.json` or `CMakeUserPresets.json`:

| Key     | Command                      | Action                     |
|:--------|:-----------------------------|:---------------------------|
| F5      | `cmake-compile-with-preset`  | Configure + build          |
| Shift-F5| `cmake-build-with-preset`    | Build only (skip configure)|

Both prompt with completion for available preset names.

## Keybindings

### Function Keys

| Key  | Command                            |
|:-----|:-----------------------------------|
| F1   | dired (file manager)               |
| F2   | dired-omit-mode (toggle junk files)|
| F3   | shell                              |
| F4   | find-file                          |
| F5   | CMake configure + build (preset)   |
| S-F5 | CMake build only (preset)          |
| F6   | visit-tags-table                   |
| F8   | add-change-log-entry               |
| F9   | treemacs                           |

### Custom Keys

| Key       | Command          |
|:----------|:-----------------|
| C-z       | undo             |
| M-SPC     | set-mark-command |
| M-C-r     | query-replace    |
| M-r       | replace-string   |
| M-g       | goto-line        |
| M-h       | help-command     |
| C-c p     | projectile map   |
| C-c c     | claude-code map  |
| C-c C-'   | claude-code-ide  |
| C-c f     | clang-format     |
| C-c m     | CLion-like multiple cursors (see below) |
| C-S-c C-S-c | mc/edit-lines (multi-cursor on selected lines) |
| C->       | mc/mark-next-like-this     |
| C-<       | mc/mark-previous-like-this |
| C-c C-<   | mc/mark-all-like-this      |

### Multiple Cursors (CLion-like)

To add cursors on adjacent lines (like CLion's Ctrl+Ctrl+arrows):

1. `C-c m` — activates rectangular region mode
2. Use `Up`/`Down` arrow keys to add cursors on adjacent lines
3. Start typing — all cursors edit simultaneously
4. `C-g` to exit multiple cursors mode

### Navigation (Keypad)

| Key       | Action              |
|:----------|:--------------------|
| C-Home    | beginning of buffer |
| C-End     | end of buffer       |
| C-Left    | backward word       |
| C-Right   | forward word        |
| C-Up      | backward sexp       |
| C-Down    | forward sexp        |

## UI Settings

- Mode line: ISO 8601 time display (`%Y-%m-%dT%H:%M`)
- Parenthesis matching: expression highlighting
- Trailing whitespace: visible and auto-deleted on save
- No toolbar, no scrollbar, menu bar enabled
- No backup files (`~`)

## Org Mode

Babel languages enabled: org, python, perl, C, lisp, scheme, shell, emacs-lisp, js.

## Git (Magit)

Open with `M-x magit` to see the status buffer.

### Typical commit + push workflow

1. **Stage** — move cursor to a file and press `s`, or `S` to stage all
2. **Commit** — press `c c`, type your message, then `C-c C-c` to finalize
3. **Push** — press `p p` to push to the remote tracking branch

### Magit status buffer keys

| Key       | Action                          |
|:----------|:--------------------------------|
| `s`       | Stage file at cursor            |
| `S`       | Stage all                       |
| `u`       | Unstage file at cursor          |
| `c c`     | Commit                          |
| `C-c C-c` | Finalize commit message         |
| `C-c C-k` | Abort commit message            |
| `p p`     | Push to remote                  |
| `F p`     | Pull from remote                |
| `l l`     | View log                        |
| `d d`     | Diff                            |
| `TAB`     | Expand/collapse diff for a file |
| `g`       | Refresh status                  |
| `q`       | Quit Magit buffer               |

## Claude Code

Two packages for Claude Code integration:

- [claude-code.el](https://github.com/stevemolitor/claude-code.el) — `C-c c` prefix
- [claude-code-ide.el](https://github.com/manzaltu/claude-code-ide.el) — `C-c C-'` menu with Emacs MCP tools
