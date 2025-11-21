#!/bin/bash

# Neovim Configuration Installation Script for macOS
# This script installs all dependencies needed for the Neovim configuration

set -e

echo "================================"
echo "Neovim Config Installer - macOS"
echo "================================"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✓ Homebrew already installed"
fi

# Update Homebrew
echo ""
echo "Updating Homebrew..."
brew update

# Install Neovim
echo ""
echo "Installing Neovim..."
if ! command -v nvim &> /dev/null; then
    brew install neovim
else
    echo "✓ Neovim already installed"
fi

# Install ripgrep (required for Telescope live_grep)
echo ""
echo "Installing ripgrep..."
if ! command -v rg &> /dev/null; then
    brew install ripgrep
else
    echo "✓ ripgrep already installed"
fi

# Install fd (faster file finder for Telescope)
echo ""
echo "Installing fd..."
if ! command -v fd &> /dev/null; then
    brew install fd
else
    echo "✓ fd already installed"
fi

# Install Git
echo ""
echo "Checking Git..."
if ! command -v git &> /dev/null; then
    brew install git
else
    echo "✓ Git already installed"
fi

# Install Python3 and pip
echo ""
echo "Installing Python3..."
if ! command -v python3 &> /dev/null; then
    brew install python3
else
    echo "✓ Python3 already installed"
fi

# Install Python LSP server
echo ""
echo "Installing Python LSP (pyright)..."
if ! command -v pyright &> /dev/null; then
    npm install -g pyright
else
    echo "✓ pyright already installed"
fi

# Install debugpy for Python debugging
echo ""
echo "Installing debugpy..."
pip3 install --user debugpy 2>/dev/null || echo "✓ debugpy already installed or installed system-wide"

# Install Node.js and npm (required for LSP servers)
echo ""
echo "Installing Node.js and npm..."
if ! command -v node &> /dev/null; then
    brew install node
else
    echo "✓ Node.js already installed"
fi

# Install TypeScript LSP server
echo ""
echo "Installing TypeScript LSP server..."
npm install -g typescript typescript-language-server

# Install Rust and Rust Analyzer
echo ""
echo "Installing Rust..."
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "✓ Rust already installed"
fi

echo ""
echo "Installing Rust Analyzer..."
if ! command -v rust-analyzer &> /dev/null; then
    brew install rust-analyzer
else
    echo "✓ rust-analyzer already installed"
fi

# Install Go
echo ""
echo "Installing Go..."
if ! command -v go &> /dev/null; then
    brew install go
else
    echo "✓ Go already installed"
fi

# Install Go LSP server (gopls)
echo ""
echo "Installing gopls (Go LSP server)..."
if ! command -v gopls &> /dev/null; then
    go install golang.org/x/tools/gopls@latest
else
    echo "✓ gopls already installed"
fi

# Install additional Go tools
echo ""
echo "Installing additional Go development tools..."

# Static check
if ! command -v staticcheck &> /dev/null; then
    go install honnef.co/go/tools/cmd/staticcheck@latest
else
    echo "✓ staticcheck already installed"
fi

# golangci-lint
if ! command -v golangci-lint &> /dev/null; then
    brew install golangci-lint
else
    echo "✓ golangci-lint already installed"
fi

# delve (Go debugger)
if ! command -v dlv &> /dev/null; then
    go install github.com/go-delve/delve/cmd/dlv@latest
else
    echo "✓ delve already installed"
fi

# goimports
if ! command -v goimports &> /dev/null; then
    go install golang.org/x/tools/cmd/goimports@latest
else
    echo "✓ goimports already installed"
fi

# Install Nerd Font for icons
echo ""
echo "Installing Hack Nerd Font..."
if ! brew list --cask font-hack-nerd-font &>/dev/null; then
    brew install --cask font-hack-nerd-font 2>/dev/null || echo "✓ Hack Nerd Font already installed or use 'brew install font-hack-nerd-font' manually"
else
    echo "✓ Hack Nerd Font already installed"
fi

# Create Neovim config directory if it doesn't exist
echo ""
echo "Setting up Neovim configuration..."
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    mkdir -p "$NVIM_CONFIG_DIR"
fi

# Copy init.vim to config directory
if [ -f "./init.vim" ]; then
    cp -f ./init.vim "$NVIM_CONFIG_DIR/init.vim" 2>/dev/null || true
    echo "✓ init.vim synced to $NVIM_CONFIG_DIR"
else
    echo "⚠ Warning: init.vim not found in current directory"
fi

# Install vim-plug (plugin manager)
echo ""
echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Add Go bin to PATH if not already there
echo ""
echo "Checking PATH configuration..."
GOBIN_PATH="$HOME/go/bin"
if [[ ":$PATH:" != *":$GOBIN_PATH:"* ]]; then
    echo ""
    echo "Adding Go bin directory to PATH..."
    echo "Please add the following line to your ~/.zshrc or ~/.bash_profile:"
    echo "export PATH=\"\$HOME/go/bin:\$PATH\""
fi

# Автоматическая установка плагинов
echo ""
echo "Устанавливаем плагины neovim..."

# Сначала создаем базовые директории для nvim в стандартном месте
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.local/share/nvim/site/autoload"

# Копируем init.vim
if [ -f "$SCRIPT_DIR/init.vim" ]; then
    cp -f "$SCRIPT_DIR/init.vim" "$HOME/.config/nvim/init.vim"
    echo "  ✓ init.vim скопирован в $HOME/.config/nvim"
else
    echo "  ⚠ Предупреждение: init.vim не найден в $SCRIPT_DIR"
fi

# vim-plug уже установлен выше в $HOME/.local/share/nvim/site/autoload/plug.vim

# Устанавливаем плагины используя основной конфиг
echo "  Устанавливаю плагины (это займет ~1-2 минуты)..."
timeout 180 nvim --headless +PlugInstall +qall 2>&1 | grep -E "(Updated|Installed|installed)" || true
echo "  ✓ Плагины установлены"

# Устанавливаем Treesitter парсеры
echo ""
echo "Устанавливаем Treesitter парсеры..."
cat > /tmp/install_ts.lua << 'EOFLUA'
pcall(function()
  require('nvim-treesitter.install').ensure_installed_sync({ 'python', 'go', 'typescript', 'javascript', 'rust', 'lua', 'vim', 'vimdoc', 'query', 'c', 'gomod', 'gosum', 'gowork' })
end)
EOFLUA

echo "  Устанавливаю парсеры (это займет ~1-2 минуты)..."
timeout 180 nvim --headless -c "luafile /tmp/install_ts.lua" -c "qall" 2>&1 | grep -E "(Downloading|installed|Compiling)" || true
echo "  ✓ Treesitter парсеры установлены"

# Очищаем временные файлы
rm -f /tmp/install_ts.lua

# Следующий блок больше не нужен - удаляем старый код
: << 'OLDCODE'
cat > /tmp/install_plugins.vim << 'EOFVIM'
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if filereadable(plug_path)
  execute 'source ' . plug_path
endif

call plug#begin(stdpath('config') . '/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'Pocco81/auto-save.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'marko-cerovac/material.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'tiagovla/tokyodark.nvim'
Plug 'artanikin/vim-synthwave84'
Plug 'nvim-lualine/lualine.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'folke/which-key.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-notify'
Plug 'folke/neodev.nvim'
Plug 'm4xshen/autoclose.nvim'
call plug#end()
EOFVIM
OLDCODE

echo ""
echo "================================"
echo "Installation Complete!"
echo "================================"
echo ""
echo "✓ Neovim установлен и настроен"
echo "✓ Все плагины установлены"
echo "✓ Treesitter парсеры установлены"
echo ""
echo "Запускай:"
echo "  nvim"
echo ""
echo "Горячие клавиши:"
echo "  Ctrl+n - файловое дерево"
echo "  F4 - поиск файлов"
echo "  F2 - поиск по тексту"
echo "  gd - перейти к определению"
echo "  q - инфо о символе"
echo "  jj - выход из insert режима"
echo ""
echo "Optional: Перезапусти терминал: source ~/.zshrc (или ~/.bash_profile)"
