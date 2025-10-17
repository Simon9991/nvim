# Plugin Reference

Quick reference for plugin usage and keybindings.

## Debugging (nvim-dap + nvim-dap-ui)

**Purpose:** Debug C/C++, Rust, and Go programs with breakpoints and step execution.

**Setup Required:**
- NixOS packages: `codelldb` (C/C++/Rust), `delve` (Go)

**Key Mappings:**
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue/start debugging
- `<leader>di` - Step into
- `<leader>dO` - Step over
- `<leader>do` - Step out
- `<leader>dt` - Terminate session
- `<leader>du` - Toggle debug UI
- `<leader>de` - Evaluate expression (normal/visual)
- `<leader>dr` - Toggle REPL

**Workflow:**
1. Set breakpoints with `<leader>db`
2. Start debugging with `<leader>dc`
3. UI opens automatically
4. Use step commands to navigate
5. Hover over variables or use `<leader>de` to inspect

---

## Rust Tooling (rustaceanvim)

**Purpose:** Enhanced Rust development with cargo, clippy, and better LSP integration.

**Features:**
- Cargo features autocomplete
- Clippy on save
- Inlay hints for lifetimes
- DAP integration (uses codelldb)
- Proc macro support

**Notes:**
- Replaces standalone rust-analyzer config
- Formatting still handled by conform.nvim (rustfmt)
- No special keybindings; uses standard LSP mappings

---

## Code Outline (aerial.nvim)

**Purpose:** View and navigate code structure (functions, classes, symbols).

**Key Mappings:**
- `<leader>a` - Toggle outline sidebar
- `{` / `}` - Jump to previous/next symbol (when outline open)

**Workflow:**
- Open outline in a sidebar to see file structure
- Navigate large files by jumping between symbols
- Works with LSP and Treesitter

---

## Definition/Reference Viewer (glance.nvim)

**Purpose:** Preview definitions, references, and implementations in a split view.

**Key Mappings:**
- `gd` - View definitions
- `gr` - View references
- `gy` - View type definitions
- `gi` - View implementations

**Navigation (inside glance window):**
- `j/k` - Navigate list
- `<Tab>/<S-Tab>` - Next/previous location
- `<CR>` - Jump to selection
- `v/s/t` - Open in vsplit/split/tab
- `q` - Close

**Workflow:**
- Use instead of standard LSP go-to for better preview
- Especially useful when there are multiple matches
- Falls back to standard LSP behavior if no plugin

---

## Incremental Rename (inc-rename.nvim)

**Purpose:** Live preview of LSP symbol renames across files.

**Key Mappings:**
- `<F2>` - Start incremental rename

**Workflow:**
- Press `<F2>` on a symbol
- Type new name and see changes live
- Press `<CR>` to apply or `<Esc>` to cancel

---

## Text Objects (mini.ai)

**Purpose:** Enhanced text objects for more precise selections.

**Custom Text Objects:**
- `af/if` - Around/inside function
- `ac/ic` - Around/inside class
- `ao/io` - Around/inside block/conditional/loop
- `at/it` - Around/inside HTML/XML tags
- `ad/id` - Around/inside digits
- `au/iu` - Around/inside function call (Usage)
- `ag/ig` - Around/inside whole buffer (Global)

**Usage Examples:**
- `daf` - Delete around function
- `cic` - Change inside class
- `vio` - Visual select inside block
- `yau` - Yank around function call

**Workflow:**
- Combine with operators: `d` (delete), `c` (change), `y` (yank), `v` (visual)
- More precise than built-in text objects

---

## Better Quickfix (nvim-bqf)

**Purpose:** Enhanced quickfix window with preview and fuzzy filtering.

**Features:**
- Auto preview on navigation
- Fuzzy search within quickfix
- Better keybindings

**Usage:**
- Open quickfix (`:copen`, `:Telescope quickfix`, etc.)
- Preview appears automatically
- Use `Ctrl+o` to toggle all items
- FZF fuzzy filter available

**Workflow:**
- Grep results from telescope go to quickfix
- Navigate with preview for context
- Filter large result sets with fuzzy search

---

## Git Diff Viewer (diffview.nvim)

**Purpose:** View git diffs and file history in a dedicated layout.

**Key Mappings:**
- `<leader>gd` - Open diff view
- `<leader>gh` - File history (current file)
- `<leader>gH` - Project history

**Navigation (inside diffview):**
- `<Tab>/<S-Tab>` - Next/previous file
- `]x/[x` - Next/previous conflict
- `-` - Stage/unstage file
- `S/U` - Stage/unstage all
- `q` - Close

**Merge Conflict Resolution:**
- `<leader>co` - Choose ours
- `<leader>ct` - Choose theirs
- `<leader>cb` - Choose base
- `<leader>ca` - Choose all

**Workflow:**
- Review changes before commit with `<leader>gd`
- Investigate file changes over time with `<leader>gh`
- Resolve merge conflicts visually

---

## Code Snippets (LuaSnip + friendly-snippets)

**Purpose:** Insert code templates with placeholder navigation.

**Key Mappings:**
- `<Tab>` - Expand snippet or jump to next placeholder
- `<S-Tab>` - Jump to previous placeholder

**Common Snippets:**
- JavaScript/TypeScript:
  - `log` - `console.log()`
  - `cl` - `console.log()`
  - `fn` - Function declaration
  - `af` - Arrow function
  - `switch` - Switch statement
  - `if` - If statement

- C/C++:
  - `inc` - Include statement
  - `for` - For loop
  - `switch` - Switch statement
  - `struct` - Struct definition

- Rust:
  - `fn` - Function
  - `match` - Match expression
  - `for` - For loop
  - `struct` - Struct definition

- Go:
  - `fn` - Function
  - `if` - If statement
  - `for` - For loop
  - `switch` - Switch statement

**Workflow:**
1. Type snippet trigger (e.g., `log`)
2. Press `<Tab>` to expand
3. Fill in placeholders, pressing `<Tab>` to move forward
4. Press `<S-Tab>` to go back if needed

---

## Integration Tips

**Code Navigation Flow:**
1. Use `<leader>a` (aerial) for high-level file structure
2. Use `gd` (glance) for quick definition preview
3. Use `gr` (glance) to see all references
4. Use `<F2>` (inc-rename) to rename symbols safely

**Debugging Flow:**
1. Set breakpoints with `<leader>db`
2. Start debug with `<leader>dc`
3. Use step commands (`di`, `dO`, `do`) to navigate
4. Inspect variables with `<leader>de`
5. Use REPL (`<leader>dr`) for quick expressions

**Git Review Flow:**
1. Use `<leader>gd` to review unstaged changes
2. Use `<leader>gh` to see file history
3. Stage/unstage with `-` in diffview
4. Close and commit when ready

**Text Editing Flow:**
1. Use mini.ai text objects for precise selections
2. Use snippets for boilerplate
3. Use inc-rename for refactoring
4. Use quickfix for multi-file operations
