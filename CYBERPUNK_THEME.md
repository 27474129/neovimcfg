# 🌃 CYBERPUNK NEON THEME - Enhanced

## What Changed

### 1. 🎯 Enhanced Block Cursor
- **Neon magenta cursor** in normal mode (#ff00ff)
- **Cyan cursor** in insert mode (#00ffff)
- **Pink cursor** in visual mode (#ff79c6)
- **Green cursor** in command mode (#00ff9f)
- Added cursorline highlighting for better visibility

### 2. 🎨 Cyberpunk Color Theme
- **Pure black background** (#000000) for maximum contrast
- **Bright neon colors** for all syntax elements:
  - Functions: Bright cyan (#00ffff)
  - Strings: Neon green (#00ff9f)
  - Keywords: Magenta (#ff00ff)
  - Numbers: Purple (#bd93f9)
  - Comments: Light blue (#8b8bff)
  - Operators: Pink (#ff79c6)

### 3. 📁 Enhanced File Tree (NvimTree)
- **Colorful folder icons**:
  - Closed folders: Cyan (#00ffff)
  - Open folders: Magenta (#ff00ff)
  - Folder icons: Bold magenta
- **Git status colors**:
  - New files: Bright green
  - Modified: Pink
  - Deleted: Red
  - Staged: Cyan
- **Special files**: Pink with underline
- **Executable files**: Green and bold
- All icons enabled via nvim-web-devicons

### 4. 💻 UI Enhancements
- **Bufferline**: Black background with neon separators
- **Line numbers**: Magenta (#ff00ff)
- **Current line number**: Bright cyan (#00ffff)
- **Status line**: Cyan on dark background
- **Search**: Magenta background with black text

## How to Apply

1. The changes are already in your init.vim
2. Restart Neovim or run: :source ~/.config/nvim/init.vim
3. The new theme will be applied immediately

## Keybinding Reminder

- sd - Close current buffer and go to next (was F5)
- Ctrl+n - Toggle file tree
- Tab - Next buffer
- o - Previous buffer
