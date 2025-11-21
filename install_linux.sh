#!/bin/bash

# Neovim Configuration Installation Script for Linux
# This script installs all dependencies needed for the Neovim configuration

set -e

echo "================================="
echo "Neovim Config Installer - Linux"
echo "================================="
echo ""

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect Linux distribution"
    exit 1
fi

echo "Detected OS: $OS"
echo ""

# Function to install packages based on distribution
install_package() {
    case $OS in
        ubuntu|debian)
            sudo apt-get install -y "$@"
            ;;
        fedora|rhel|centos)
            sudo dnf install -y "$@"
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm "$@"
            ;;
        *)
            echo "Unsupported distribution: $OS"
            exit 1
            ;;
    esac
}

# Update package manager
echo "Updating package manager..."
case $OS in
    ubuntu|debian)
        sudo apt-get update
        ;;
    fedora|rhel|centos)
        sudo dnf update -y
        ;;
    arch|manjaro)
        sudo pacman -Syu --noconfirm
        ;;
esac

# Install Neovim
echo ""
echo "Installing Neovim..."
if ! command -v nvim &> /dev/null; then
    case $OS in
        ubuntu|debian)
            # For Ubuntu/Debian, use PPA for latest version
            sudo add-apt-repository ppa:neovim-ppa/unstable -y
            sudo apt-get update
            install_package neovim
            ;;
        fedora|rhel|centos)
            install_package neovim
            ;;
        arch|manjaro)
            install_package neovim
            ;;
    esac
else
    echo "✓ Neovim already installed"
fi

# Install basic build tools
echo ""
echo "Installing build essentials..."
case $OS in
    ubuntu|debian)
        install_package build-essential curl wget git
        ;;
    fedora|rhel|centos)
        install_package gcc gcc-c++ make curl wget git
        ;;
    arch|manjaro)
        install_package base-devel curl wget git
        ;;
esac

# Install ripgrep
echo ""
echo "Installing ripgrep..."
if ! command -v rg &> /dev/null; then
    install_package ripgrep
else
    echo "✓ ripgrep already installed"
fi

# Install fd-find
echo ""
echo "Installing fd..."
if ! command -v fd &> /dev/null; then
    case $OS in
        ubuntu|debian)
            install_package fd-find
            # Create symlink for fd-find on Ubuntu/Debian
            if [ ! -f /usr/local/bin/fd ]; then
                sudo ln -s $(which fdfind) /usr/local/bin/fd 2>/dev/null || true
            fi
            ;;
        fedora|rhel|centos)
            install_package fd-find
            ;;
        arch|manjaro)
            install_package fd
            ;;
    esac
else
    echo "✓ fd already installed"
fi

# Install xclip (for clipboard support)
echo ""
echo "Installing xclip..."
if ! command -v xclip &> /dev/null; then
    install_package xclip
else
    echo "✓ xclip already installed"
fi

# Install Python3 and pip
echo ""
echo "Installing Python3..."
if ! command -v python3 &> /dev/null; then
    case $OS in
        ubuntu|debian)
            install_package python3 python3-pip python3-venv
            ;;
        fedora|rhel|centos)
            install_package python3 python3-pip
            ;;
        arch|manjaro)
            install_package python python-pip
            ;;
    esac
else
    echo "✓ Python3 already installed"
fi

# Install Node.js and npm
echo ""
echo "Installing Node.js and npm..."
if ! command -v node &> /dev/null; then
    case $OS in
        ubuntu|debian)
            # Install Node.js 18.x LTS
            curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
            install_package nodejs
            ;;
        fedora|rhel|centos)
            curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
            install_package nodejs
            ;;
        arch|manjaro)
            install_package nodejs npm
            ;;
    esac
else
    echo "✓ Node.js already installed"
fi

# Install Python LSP server
echo ""
echo "Installing Python LSP (pyright)..."
if ! command -v pyright &> /dev/null; then
    sudo npm install -g pyright
else
    echo "✓ pyright already installed"
fi

# Install debugpy for Python debugging
echo ""
echo "Installing debugpy..."
pip3 install --user debugpy

# Install TypeScript LSP server
echo ""
echo "Installing TypeScript LSP server..."
if ! command -v typescript-language-server &> /dev/null; then
    sudo npm install -g typescript typescript-language-server
else
    echo "✓ TypeScript LSP already installed"
fi

# Install Rust
echo ""
echo "Installing Rust..."
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "✓ Rust already installed"
fi

# Install Rust Analyzer
echo ""
echo "Installing Rust Analyzer..."
if ! command -v rust-analyzer &> /dev/null; then
    case $OS in
        ubuntu|debian)
            # Install from rustup
            rustup component add rust-analyzer
            ;;
        fedora|rhel|centos)
            install_package rust-analyzer
            ;;
        arch|manjaro)
            install_package rust-analyzer
            ;;
    esac
else
    echo "✓ rust-analyzer already installed"
fi

# Install Go
echo ""
echo "Installing Go..."
if ! command -v go &> /dev/null; then
    case $OS in
        ubuntu|debian)
            # Download and install latest Go
            GO_VERSION="1.21.5"
            wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
            sudo rm -rf /usr/local/go
            sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
            rm "go${GO_VERSION}.linux-amd64.tar.gz"
            ;;
        fedora|rhel|centos)
            install_package golang
            ;;
        arch|manjaro)
            install_package go
            ;;
    esac
    # Add Go to PATH for current session
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
else
    echo "✓ Go already installed"
fi

# Ensure Go bin is in PATH
export PATH=$PATH:$HOME/go/bin

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
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin
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

# Install Nerd Font
echo ""
echo "Installing Hack Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR"
if [ ! -f "Hack Regular Nerd Font Complete.ttf" ]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
    unzip -o Hack.zip
    rm Hack.zip
    fc-cache -fv
    echo "✓ Hack Nerd Font installed"
else
    echo "✓ Hack Nerd Font already installed"
fi

# Create Neovim config directory
echo ""
echo "Setting up Neovim configuration..."
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    mkdir -p "$NVIM_CONFIG_DIR"
fi

# Copy init.vim to config directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/init.vim" ]; then
    cp "$SCRIPT_DIR/init.vim" "$NVIM_CONFIG_DIR/init.vim"
    echo "✓ init.vim copied to $NVIM_CONFIG_DIR"
else
    echo "⚠ Warning: init.vim not found in script directory"
fi

# Install vim-plug
echo ""
echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Update PATH configuration
echo ""
echo "Updating PATH configuration..."

# Determine shell config file
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
else
    SHELL_CONFIG="$HOME/.profile"
fi

# Add Go paths if not already present
if ! grep -q "go/bin" "$SHELL_CONFIG"; then
    echo "" >> "$SHELL_CONFIG"
    echo "# Go configuration" >> "$SHELL_CONFIG"
    echo "export PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin" >> "$SHELL_CONFIG"
    echo "✓ Go paths added to $SHELL_CONFIG"
fi

# Add Rust paths if not already present
if ! grep -q ".cargo/env" "$SHELL_CONFIG"; then
    echo "" >> "$SHELL_CONFIG"
    echo "# Rust configuration" >> "$SHELL_CONFIG"
    echo ". \"\$HOME/.cargo/env\"" >> "$SHELL_CONFIG"
    echo "✓ Rust paths added to $SHELL_CONFIG"
fi

echo ""
echo "================================="
echo "Installation Complete!"
echo "================================="
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source $SHELL_CONFIG"
echo "2. Open Neovim with: nvim"
echo "3. Install plugins with: :PlugInstall"
echo "4. Install Treesitter parsers with: :TSInstall python go typescript rust"
echo ""
echo "Optional: You may need to restart your terminal for all changes to take effect"
