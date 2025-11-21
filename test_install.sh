#!/bin/bash

# Скрипт для проверки установки Neovim конфига

echo "==================================="
echo "Проверка установки Neovim"
echo "==================================="
echo ""

# Проверяем neovim
if command -v nvim &> /dev/null; then
    echo "✓ Neovim установлен: $(nvim --version | head -1)"
else
    echo "✗ Neovim НЕ установлен"
    exit 1
fi

# Проверяем директории
NVIM_DATA_DIR="$(nvim --headless -c 'echo stdpath("data")' -c 'qall' 2>/dev/null | tail -1)"
NVIM_CONFIG_DIR="$(nvim --headless -c 'echo stdpath("config")' -c 'qall' 2>/dev/null | tail -1)"

echo "  Data dir: $NVIM_DATA_DIR"
echo "  Config dir: $NVIM_CONFIG_DIR"

# Проверяем vim-plug
if [ -f "$NVIM_DATA_DIR/site/autoload/plug.vim" ]; then
    echo "✓ vim-plug установлен"
else
    echo "✗ vim-plug НЕ установлен"
fi

# Проверяем init.vim
if [ -f "$NVIM_CONFIG_DIR/init.vim" ]; then
    echo "✓ init.vim найден"
else
    echo "✗ init.vim НЕ найден"
fi

# Проверяем плагины
PLUGIN_COUNT=$(ls "$NVIM_CONFIG_DIR/plugged/" 2>/dev/null | wc -l)
echo "✓ Плагинов установлено: $PLUGIN_COUNT"

# Проверяем что vim-plug загружается
VIM_PLUG_LOADED=$(nvim --headless -c 'echo exists("g:loaded_plug")' -c 'qall' 2>/dev/null | tail -1)
if [ "$VIM_PLUG_LOADED" = "1" ]; then
    echo "✓ vim-plug загружается"
    PLUGINS_REGISTERED=$(nvim --headless -c 'echo len(g:plugs)' -c 'qall' 2>/dev/null | tail -1)
    echo "  Плагинов зарегистрировано: $PLUGINS_REGISTERED"
else
    echo "✗ vim-plug НЕ загружается"
fi

# Проверяем тему
THEME=$(nvim --headless -c 'colorscheme tokyonight' -c 'echo g:colors_name' -c 'qall' 2>/dev/null | tail -1)
if [ -n "$THEME" ]; then
    echo "✓ Тема загружается: $THEME"
else
    echo "✗ Тема НЕ загружается"
fi

# Проверяем LSP серверы
echo ""
echo "LSP серверы:"
command -v pyright &> /dev/null && echo "  ✓ pyright" || echo "  ✗ pyright"
command -v typescript-language-server &> /dev/null && echo "  ✓ typescript-language-server" || echo "  ✗ typescript-language-server"
command -v rust-analyzer &> /dev/null && echo "  ✓ rust-analyzer" || echo "  ✗ rust-analyzer"
command -v gopls &> /dev/null && echo "  ✓ gopls" || echo "  ✗ gopls"

# Проверяем Treesitter парсеры
echo ""
PARSER_COUNT=$(find "$NVIM_CONFIG_DIR/plugged/nvim-treesitter/parser" -name "*.so" 2>/dev/null | wc -l)
echo "✓ Treesitter парсеров: $PARSER_COUNT"

# Проверяем ошибки при загрузке
echo ""
echo "Проверка ошибок при загрузке..."
ERROR_COUNT=$(nvim --headless -c 'messages' -c 'qall' 2>&1 | grep -i "error" | wc -l)
if [ "$ERROR_COUNT" -eq "0" ]; then
    echo "✓ Ошибок при загрузке: 0"
else
    echo "⚠ Ошибок при загрузке: $ERROR_COUNT"
    echo "  (Запусти 'nvim --headless -c messages -c qall' для деталей)"
fi

echo ""
echo "==================================="
echo "Проверка завершена!"
echo "==================================="

