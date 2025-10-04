# Custom Neovim Configuration

Built from scratch for full-stack TypeScript development.

## System Requirements
- Neovim 0.11+
- Node.js (for LSP servers)
- ripgrep (for Telescope grep)
- git

## Features
- **LSP**: TypeScript, ESLint, Lua
- **Completion**: nvim-cmp with LSP integration
- **Formatting**: Prettier (auto-format on save)
- **Treesitter**: Syntax highlighting
- **Telescope**: Fuzzy finding
- **Neo-tree**: File explorer
- **Git integration**: Gitsigns

## Key Bindings

### Leader Key: Space

#### File Navigation
- `<Space>ff` - Find files
- `<Space>fg` - Live grep
- `<Space>fb` - Find buffers
- `<Space>fr` - Recent files
- `<Space>e` - Toggle file explorer

#### LSP
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<Space>ca` - Code actions
- `<Space>rn` - Rename
- `<Space>d` - Show diagnostics
- `[d` / `]d` - Previous/next diagnostic

#### Formatting
- `<Space>mp` - Manual format
- Auto-formats on save

#### Window Management
- `<Space>sv` - Split vertical
- `<Space>sh` - Split horizontal
- `<Space>se` - Equal splits
- `<Space>sx` - Close split
- `<C-h/j/k/l>` - Navigate splits

#### Editing
- `gc` (visual) - Toggle comment
- `<` / `>` (visual) - Indent left/right
- `J` / `K` (visual) - Move lines up/down

## Plugin Versions (Pinned for Stability)
All plugins are version-pinned to prevent breaking changes.
Check `lua/plugins/*.lua` for specific versions.

## Installation
```bash
git clone  Neovim-Config ~/.config/nvim
Nvim
