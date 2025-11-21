call plug#begin('~/.config/nvim/plugged')
" Base
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
Plug 'neovim/nvim-lspconfig'
" Refactoring plug
Plug 'glepnir/lspsaga.nvim'

" for this plugin need to TSInstall python
Plug 'nvim-treesitter/nvim-treesitter'

" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" autosave
Plug 'Pocco81/auto-save.nvim'

" tree
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" color schemes
Plug 'marko-cerovac/material.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Cyberpunk themes
Plug 'tiagovla/tokyodark.nvim'
Plug 'artanikin/vim-synthwave84'

" Beautiful statusline
Plug 'nvim-lualine/lualine.nvim'

Plug 'numToStr/Comment.nvim'

Plug 'folke/which-key.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Debug plugins
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-notify'
Plug 'folke/neodev.nvim'

" Auto close brackets
Plug 'm4xshen/autoclose.nvim'

call plug#end()

" Base settings

" Enable true colors
set termguicolors

" Better syntax highlighting
syntax enable

" Increase font size (for GUI nvim) - using full Nerd Font name
set guifont=HackNerdFontMono-Regular:h14

" Enhanced cursor settings
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
set cursorline

" Cyberpunk Color Scheme Configuration
lua << EOF
-- Configure tokyonight for cyberpunk look
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
EOF

" color scheme
set background=dark
colorscheme tokyonight

" NEON CYBERPUNK THEME - Enhanced Consistency
lua << EOF
vim.cmd([[
  " Main editor colors - Deep black with cyan/magenta neon
  highlight Normal guibg=#000000 guifg=#00ffff
  highlight NormalFloat guibg=#0a0520 guifg=#00ffff
  highlight LineNr guifg=#ff0080 guibg=#000000
  highlight CursorLineNr guifg=#00ffff gui=bold
  highlight CursorLine guibg=#0d1117 gui=none
  highlight ColorColumn guibg=#0a0520

  " NEON GLOW CURSOR
  highlight Cursor guibg=#00ffff guifg=#000000 gui=bold,reverse
  highlight iCursor guibg=#ff0080 guifg=#000000 gui=bold,reverse
  highlight vCursor guibg=#ff0080 guifg=#000000 gui=bold,reverse
  highlight lCursor guibg=#00ffff guifg=#000000 gui=bold,reverse
  highlight CursorColumn guibg=#0d1117

  " Syntax - Cyan + Magenta + Purple neon palette
  highlight Comment guifg=#8b5cf6 gui=italic
  highlight Constant guifg=#ff0080 gui=bold
  highlight String guifg=#00ffff gui=bold
  highlight Character guifg=#ff0080
  highlight Number guifg=#ff00ff gui=bold
  highlight Boolean guifg=#ff0080 gui=bold
  highlight Float guifg=#ff00ff gui=bold
  highlight Function guifg=#00ffff gui=bold
  highlight Statement guifg=#ff0080 gui=bold
  highlight Conditional guifg=#ff0080 gui=italic,bold
  highlight Repeat guifg=#ff0080 gui=bold
  highlight Label guifg=#00ffff gui=bold
  highlight Operator guifg=#ff00ff gui=bold
  highlight Keyword guifg=#ff0080 gui=bold,italic
  highlight Type guifg=#00ffff gui=bold
  highlight Special guifg=#ff00ff gui=bold
  highlight Identifier guifg=#00ffff
  highlight PreProc guifg=#ff00ff gui=bold
  highlight Include guifg=#ff0080 gui=bold
  highlight Define guifg=#00ffff gui=bold
  highlight Macro guifg=#ff00ff gui=bold

  " UI Elements - Consistent neon theme
  highlight VertSplit guifg=#00ffff guibg=#000000 gui=bold
  highlight StatusLine guifg=#00ffff guibg=#0a0520 gui=bold
  highlight StatusLineNC guifg=#8b5cf6 guibg=#000000
  highlight TabLine guifg=#8b5cf6 guibg=#000000
  highlight TabLineFill guibg=#000000
  highlight TabLineSel guifg=#00ffff guibg=#0a0520 gui=bold
  highlight Pmenu guibg=#0a0520 guifg=#00ffff
  highlight PmenuSel guibg=#ff0080 guifg=#000000 gui=bold
  highlight PmenuSbar guibg=#0a0520
  highlight PmenuThumb guibg=#ff0080
  highlight WinSeparator guifg=#00ffff guibg=#000000 gui=bold

  " Search highlighting - Magenta + Cyan glow
  highlight Search guibg=#ff0080 guifg=#000000 gui=bold
  highlight IncSearch guibg=#00ffff guifg=#000000 gui=bold
  highlight Visual guibg=#ff0080 guifg=#000000 gui=bold

  " NvimTree - Consistent neon theme
  highlight NvimTreeNormal guibg=#000000 guifg=#00ffff
  highlight NvimTreeEndOfBuffer guibg=#000000
  highlight NvimTreeCursorLine guibg=#0d1117 gui=none
  highlight NvimTreeFolderName guifg=#00ffff gui=bold
  highlight NvimTreeOpenedFolderName guifg=#ff0080 gui=bold
  highlight NvimTreeEmptyFolderName guifg=#8b5cf6
  highlight NvimTreeFolderIcon guifg=#00ffff gui=bold
  highlight NvimTreeRootFolder guifg=#ff0080 gui=bold
  highlight NvimTreeGitDirty guifg=#ff00ff gui=bold
  highlight NvimTreeGitNew guifg=#00ffff gui=bold
  highlight NvimTreeGitDeleted guifg=#ff0080 gui=bold
  highlight NvimTreeGitStaged guifg=#00ffff gui=bold
  highlight NvimTreeSpecialFile guifg=#ff00ff gui=bold,underline
  highlight NvimTreeIndentMarker guifg=#8b5cf6
  highlight NvimTreeExecFile guifg=#00ffff gui=bold
  highlight NvimTreeImageFile guifg=#ff0080
  highlight NvimTreeSymlink guifg=#ff00ff gui=italic

  " Diagnostics - Neon error colors
  highlight DiagnosticError guifg=#ff0080 gui=bold
  highlight DiagnosticWarn guifg=#ff00ff gui=bold
  highlight DiagnosticInfo guifg=#00ffff gui=bold
  highlight DiagnosticHint guifg=#8b5cf6

  " Git signs - Bright neon colors
  highlight GitSignsAdd guifg=#00ff00 gui=bold
  highlight GitSignsChange guifg=#ff00ff gui=bold
  highlight GitSignsDelete guifg=#ff0080 gui=bold
  highlight GitSignsUntracked guifg=#00ffff gui=bold

  " Telescope - Neon theme for fuzzy finder
  highlight TelescopeBorder guifg=#00ffff gui=bold
  highlight TelescopePromptBorder guifg=#ff0080 gui=bold
  highlight TelescopeResultsBorder guifg=#00ffff gui=bold
  highlight TelescopePreviewBorder guifg=#00ffff gui=bold
  highlight TelescopeSelection guibg=#0d1117 guifg=#00ffff gui=bold
  highlight TelescopeMatching guifg=#ff0080 gui=bold
]])
EOF
inoremap jj <esc>
set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
filetype indent on      " load filetype-specific indent files

" for tabulation
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

lua << EOF
-- Quit nvim (only in normal mode, not while typing)
vim.api.nvim_set_keymap('n', '<C-a>', ':q!<CR>', {noremap = true, silent = true})

-- Window navigation (move between file tree and editor)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})

-- Close current buffer but keep window open
vim.api.nvim_set_keymap('n', '<Leader>x', ':bdelete<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'x', ':bdelete<CR>', {noremap = true, silent = true})
EOF

lua << EOF
-- Undo/Redo shortcuts (like Ctrl+Z in Windows)
vim.api.nvim_set_keymap("n", "<C-z>", "u", {noremap = true})  -- Ctrl+Z for undo
vim.api.nvim_set_keymap("n", "<C-y>", "<C-r>", {noremap = true})  -- Ctrl+Y for redo
vim.api.nvim_set_keymap("i", "<C-z>", "<Esc>ui", {noremap = true})  -- Ctrl+Z in insert mode

-- Remove dangerous 'r' binding for rename (was too easy to trigger accidentally)
-- Rename is still available via 't' key (see line 312 below)
EOF

" Copy and paste in special clipboard
lua << EOF
-- Copy to system clipboard - Ctrl+C (visual mode)
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true})

-- Simple two-letter clipboard commands
-- cy = copy to system clipboard (normal and visual mode)
vim.api.nvim_set_keymap("n", "cy", '"+yy', { noremap = true}) -- copy current line
vim.api.nvim_set_keymap("v", "cy", '"+y', { noremap = true})  -- copy selection

-- cp = paste from system clipboard (normal and visual mode)
vim.api.nvim_set_keymap("n", "cp", '"+p', { noremap = true})
vim.api.nvim_set_keymap("v", "cp", '"+p', { noremap = true})

-- Paste
function paste_from_clipboard()
   -- Get the system clipboard content using the OS-specific command
   local command = ""
   local platform = vim.fn.systemlist('uname')[1]

   if platform == "Darwin" then
       command = "pbpaste"
   elseif platform == "Linux" then
       command = "xclip -o -selection clipboard"
   elseif platform == "Windows" then
       command = "powershell.exe -command Get-Clipboard"
   end

   -- Read the output of the command and insert it into the buffer
   local content = vim.fn.system(command)
   content = content:gsub("\n$", "") -- Remove trailing newlines

   -- Determine the current mode and insert the content accordingly
   local mode = vim.api.nvim_get_mode().mode
   if mode == "i" or mode == "ic" then
       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-R>+<Esc>", true, true, true), "n", false)
   else
       vim.api.nvim_put({content}, "c", true, true)
   end
end

-- Bind Ctrl+V to the paste_from_clipboard function in normal, visual, and insert mode
vim.api.nvim_set_keymap("n", "<C-v>", ":lua paste_from_clipboard()<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "<C-v>", ":lua paste_from_clipboard()<CR>", {noremap = true})
vim.api.nvim_set_keymap("i", "<C-v>", "<Esc>:lua paste_from_clipboard()<CR>a", {noremap = true})
EOF

" Close current buffer and go to next one (only in normal mode, not while typing)
lua << EOF
vim.api.nvim_set_keymap('n', 'sd', ':bdelete<CR>:bnext<CR>', { noremap = true, silent = true })
EOF

autocmd FileType python set colorcolumn=100
autocmd FileType go set colorcolumn=100
" Suppress lspconfig deprecation warnings for nvim 0.11 compatibility
lua << EOF
local original_deprecate = vim.deprecate
vim.deprecate = function(name, alternative, version, plugin, backtrace)
  -- Suppress lspconfig framework deprecation warning
  if name and (name:match("lspconfig") or plugin == "nvim-lspconfig") then
    return
  end
  original_deprecate(name, alternative, version, plugin, backtrace)
end
EOF

" Plugin settings
lua << EOF
-- Telescope shortcuts (F-keys work everywhere, but kept only in normal mode for consistency)
vim.api.nvim_set_keymap("n", "<F4>", ":Telescope find_files<cr>", { noremap = true})
vim.api.nvim_set_keymap("n", "<F2>", ":Telescope live_grep<cr>", { noremap = true})
vim.api.nvim_set_keymap("n", "<F3>", ":Telescope buffers<cr>", { noremap = true})

-- Tree shortcuts (only in normal mode)
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<cr>", { noremap = true})

-- Buffer line shortcuts
-- Movement
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "o", ":BufferLineCyclePrev<cr>", {noremap = true})

-- Actions (only in normal mode)
vim.api.nvim_set_keymap("n", "<C-k>", ":BufferLineCloseOthers<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-r>", ":BufferLineCloseRight<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCloseLeft<cr>", {noremap = true})

-- Git shortcuts (only in normal mode)
-- F1 - Show who wrote this line (git blame)
vim.api.nvim_set_keymap("n", "<F1>", ":Gitsigns blame_line<cr>", {noremap = true})

-- Git blame for visual selection (select block and press F1)
vim.api.nvim_set_keymap("v", "<F1>", ":lua show_git_blame_for_selection()<CR>", {noremap = true, silent = true})

-- Function to show git blame for selected lines
function show_git_blame_for_selection()
  -- Get visual selection range
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local current_file = vim.fn.expand("%")

  -- Check if file exists in git
  if current_file == "" then
    print("No file selected")
    return
  end

  -- Run git blame for the selected range (using relative path from git root)
  local cmd = string.format("git blame -L %d,%d -- %s", start_line, end_line, vim.fn.shellescape(current_file))
  local blame_output = vim.fn.systemlist(cmd)

  -- Check for errors
  if vim.v.shell_error ~= 0 then
    print("Error: " .. table.concat(blame_output, "\n"))
    return
  end

  -- Create a buffer to show the results
  local buf = vim.api.nvim_create_buf(false, true)

  -- Format output nicely
  local formatted_output = {"Git Blame for lines " .. start_line .. "-" .. end_line .. ":", ""}
  for _, line in ipairs(blame_output) do
    table.insert(formatted_output, line)
  end

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted_output)

  -- Calculate window size
  local width = math.min(120, vim.o.columns - 4)
  local height = math.min(#formatted_output + 2, vim.o.lines - 4)

  -- Open floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Git Blame ',
    title_pos = 'center',
  })

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- Close window with q or Esc
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', {noremap = true, silent = true})
end

-- Usages
-- vim.api.nvim_set_keymap('n', '<leader>fr', ':lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'f', ':lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})

-- Refactoring
vim.api.nvim_set_keymap('n', 't', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true, silent = true})

-- Object info
vim.api.nvim_set_keymap('n', 'q', ':lua vim.lsp.buf.hover()<CR>', {noremap = true})
EOF

lua << EOF
require('Comment').setup()
EOF

"lua << EOF
"vim.cmd 'colorscheme material'
"EOF

lua << EOF
-- Setup language servers.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Disable inlay hints globally
vim.lsp.inlay_hint.enable(false)

-- Disable automatic hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  max_width = 80,
  max_height = 20,
})

-- Disable automatic signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  focusable = false,
  silent = true,
})

lspconfig.pyright.setup {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        inlayHints = {
          variableTypes = false,
          functionReturnTypes = false,
        }
      }
    }
  }
}
lspconfig.ts_ls.setup {
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'none',
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
      }
    }
  }
}
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      inlayHints = {
        enable = false,
      }
    },
  },
}

-- Golang LSP setup with full support
lspconfig.gopls.setup {
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Enable formatting on save for Go files
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
}


-- Disable diagnostic signs in the gutter (no more "E" symbols)
vim.diagnostic.config({
  signs = false,  -- Disable "E", "W", "I", "H" signs in the left column
  virtual_text = true,  -- Keep inline error messages
  underline = true,  -- Keep underline for errors
  update_in_insert = false,  -- Don't show diagnostics while typing
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "go", "gomod", "gosum", "gowork" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = {
        border = "rounded",
        max_width = 60,
        max_height = 15,
      },
    },
    view = {
      entries = {name = 'custom', selection_order = 'near_cursor' }
    },
    experimental = {
      ghost_text = false,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- LSP capabilities are configured above in the main LSP setup section
EOF

lua << EOF
	require("auto-save").setup {
		-- your config goes here
		-- or just leave it empty :)
	}
EOF


lua << EOF
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 45,
    side = "left",
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = true,
  },
})
EOF

" Buffer line settings
set termguicolors
lua << EOF
-- require("bufferline").setup{}
require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    -- numbers = "both", -- | function({ ordinal, id, lower, raise }): string,
    --- @deprecated, please specify numbers as a function to customize the styling
    number_style = "superscript", -- | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp", -- | "coc",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      if buf_numbers[1] ~= buf_number then
        return true
      end
    end,
    offsets = {{filetype = "NvimTree", text = "⚡ CYBERPUNK FILES", text_align = "center"}},
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "slant",
    enforce_regular_tabs = true,
    always_show_bufferline = true
  },
  highlights = {
    fill = {
      bg = '#000000',
    },
    background = {
      fg = '#4d79ff',
      bg = '#000000',
    },
    buffer_visible = {
      fg = '#00d4ff',
      bg = '#0a1520',
      bold = true,
    },
    buffer_selected = {
      fg = '#00ffff',
      bg = '#0a1520',
      bold = true,
      italic = false,
    },
    modified = {
      fg = '#ff0066',
      bg = '#000000',
      bold = true,
    },
    modified_visible = {
      fg = '#ff0066',
      bg = '#0a1520',
      bold = true,
    },
    modified_selected = {
      fg = '#ff3399',
      bg = '#0a1520',
      bold = true,
    },
    separator = {
      fg = '#00d4ff',
      bg = '#000000',
    },
    separator_visible = {
      fg = '#00d4ff',
      bg = '#0a1520',
    },
    separator_selected = {
      fg = '#00ffff',
      bg = '#0a1520',
    },
    indicator_selected = {
      fg = '#00ffff',
      bg = '#0a1520',
    },
    diagnostic = {
      fg = '#ff0066',
      bg = '#000000',
    },
    hint = {
      fg = '#00ffff',
      bg = '#000000',
    },
    info = {
      fg = '#00d4ff',
      bg = '#000000',
    },
    warning = {
      fg = '#ff6600',
      bg = '#000000',
    },
    error = {
      fg = '#ff0066',
      bg = '#000000',
    },
  }
}

-- Blade Runner Bufferline - Blue + Red
vim.cmd([[
  highlight BufferLineFill guibg=#000000
  highlight BufferLineBackground guifg=#4d79ff guibg=#000000
  highlight BufferLineBufferSelected guifg=#00ffff guibg=#0a1520 gui=bold
  highlight BufferLineBufferVisible guifg=#00d4ff guibg=#0a1520 gui=bold
  highlight BufferLineNumbers guifg=#ff0066 gui=bold
  highlight BufferLineCloseButton guifg=#ff0066 gui=bold
]])
EOF

lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}
require'nvim-web-devicons'.get_icons()
EOF


lua << EOF
require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
auto_reload_on_write = true,
disable_netrw = false,
hijack_cursor = false,
hijack_netrw = true,
hijack_unnamed_buffer_when_opening = false,
sort = {
  sorter = "name",
  folders_first = true,
},
root_dirs = {},
prefer_startup_root = false,
sync_root_with_cwd = false,
reload_on_bufenter = false,
respect_buf_cwd = false,
on_attach = "default",
select_prompts = false,
view = {
  centralize_selection = false,
  cursorline = true,
  debounce_delay = 15,
  width = 45,
  side = "left",
  preserve_window_proportions = false,
  number = false,
  relativenumber = false,
  signcolumn = "yes",
  float = {
    enable = false,
    quit_on_focus_loss = true,
    open_win_config = {
      relative = "editor",
      border = "rounded",
      width = 30,
      height = 30,
      row = 1,
      col = 1,
    },
  },
},
renderer = {
  add_trailing = false,
  group_empty = false,
  highlight_git = true,
  full_name = false,
  highlight_opened_files = "all",
  highlight_modified = "name",
  root_folder_label = ":~:s?$?/..?",
  indent_width = 2,
  indent_markers = {
    enable = true,
    inline_arrows = true,
    icons = {
      corner = "└",
      edge = "│",
      item = "│",
      bottom = "─",
      none = " ",
    },
  },
  icons = {
    webdev_colors = true,
    git_placement = "before",
    modified_placement = "after",
    padding = " ",
    symlink_arrow = " ➛ ",
    show = {
      file = true,
      folder = true,
      folder_arrow = true,
      git = true,
      modified = true,
    },
    glyphs = {
      default = "",
      symlink = "",
      bookmark = "󰆤",
      modified = "●",
      git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌",
      },
    },
  },
  special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  symlink_destination = true,
},
hijack_directories = {
  enable = true,
  auto_open = true,
},
update_focused_file = {
  enable = false,
  update_root = false,
  ignore_list = {},
},
system_open = {
  cmd = "",
  args = {},
},
diagnostics = {
  enable = false,
  show_on_dirs = false,
  show_on_open_dirs = true,
  debounce_delay = 50,
  severity = {
    min = vim.diagnostic.severity.HINT,
    max = vim.diagnostic.severity.ERROR,
  },
},
filters = {
  git_ignored = false,
  dotfiles = false,
  git_clean = false,
  no_buffer = false,
  custom = {},
  exclude = {},
},
filesystem_watchers = {
  enable = true,
  debounce_delay = 50,
  ignore_dirs = {},
},
git = {
  enable = true,
  show_on_dirs = true,
  show_on_open_dirs = true,
  disable_for_dirs = {},
  timeout = 400,
},
modified = {
  enable = false,
  show_on_dirs = true,
  show_on_open_dirs = true,
},
actions = {
  use_system_clipboard = true,
  change_dir = {
    enable = true,
    global = false,
    restrict_above_cwd = false,
  },
  expand_all = {
    max_folder_discovery = 300,
    exclude = {},
  },
  file_popup = {
    open_win_config = {
      col = 1,
      row = 1,
      relative = "cursor",
      border = "shadow",
      style = "minimal",
    },
  },
  open_file = {
    quit_on_open = false,
    resize_window = true,
    window_picker = {
      enable = true,
      picker = "default",
      chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      exclude = {
        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
        buftype = { "nofile", "terminal", "help" },
      },
    },
  },
  remove_file = {
    close_window = true,
  },
},
trash = {
  cmd = "gio trash",
},
live_filter = {
  prefix = "[FILTER]: ",
  always_show_folders = true,
},
tab = {
  sync = {
    open = false,
    close = false,
    ignore = {},
  },
},
notify = {
  threshold = vim.log.levels.INFO,
  absolute_path = true,
},
ui = {
  confirm = {
    remove = true,
    trash = true,
  },
},
experimental = {},
log = {
  enable = false,
  truncate = false,
  types = {
    all = false,
    config = false,
    copy_paste = false,
    dev = false,
    diagnostics = false,
    git = false,
    profile = false,
    watcher = false,
  },
},
}
EOF


lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '-' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '+' },  -- Show + for new files too
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Show git blame for current line (like PyCharm)
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500, -- Show blame after 500ms (faster than default)
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}
EOF

lua << EOF
require("ibl").setup {
  indent = {
    char = "│",
    tab_char = "│",
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
  },
  exclude = {
    filetypes = {
      "help",
      "terminal",
      "lazy",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "nvim-tree",
      ""
    }
  }
}
EOF

lua << EOF
require("autoclose").setup({
   options = {
      disabled_filetypes = { "text", "markdown" },
   },
})
EOF

lua << EOF
-- Configure Catppuccin theme
local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_ok then
  return
end

catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = { "bold" },
        operators = {},
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        native_lsp = {
            enabled = true,
        },
    },
})
EOF

lua << EOF
-- Configure Lualine with Cyberpunk theme
local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  return
end

-- Custom Cyberpunk theme for lualine
local cyberpunk_theme = {
  normal = {
    a = { fg = '#0a0e14', bg = '#00ffff', gui = 'bold' },
    b = { fg = '#00ff9f', bg = '#1a1e24' },
    c = { fg = '#00ff9f', bg = '#0a0e14' },
  },
  insert = {
    a = { fg = '#0a0e14', bg = '#ff00ff', gui = 'bold' },
    b = { fg = '#00ff9f', bg = '#1a1e24' },
    c = { fg = '#00ff9f', bg = '#0a0e14' },
  },
  visual = {
    a = { fg = '#0a0e14', bg = '#ff79c6', gui = 'bold' },
    b = { fg = '#00ff9f', bg = '#1a1e24' },
    c = { fg = '#00ff9f', bg = '#0a0e14' },
  },
  replace = {
    a = { fg = '#0a0e14', bg = '#ff0055', gui = 'bold' },
    b = { fg = '#00ff9f', bg = '#1a1e24' },
    c = { fg = '#00ff9f', bg = '#0a0e14' },
  },
  command = {
    a = { fg = '#0a0e14', bg = '#00ff9f', gui = 'bold' },
    b = { fg = '#00ff9f', bg = '#1a1e24' },
    c = { fg = '#00ff9f', bg = '#0a0e14' },
  },
  inactive = {
    a = { fg = '#6272a4', bg = '#0a0e14' },
    b = { fg = '#6272a4', bg = '#0a0e14' },
    c = { fg = '#6272a4', bg = '#0a0e14' },
  },
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = cyberpunk_theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'nvim-tree'}
}
EOF

lua << EOF
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "moon", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = false, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "storm", -- style for sidebars, see below
    floats = "storm", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})
EOF

lua << EOF
local dap = require('dap')
dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = '/usr/local/bin/python3.7',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end


local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Django',
    program = vim.fn.getcwd() .. '/manage.py',  -- NOTE: Adapt path to manage.py as needed
    command = '/usr/local/bin/python3.7',
    args = {'runserver'},
    django = true
  },
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";
    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    program = "${file}"; -- This configuration will launch the current file if used.
  } 
}

vim.keymap.set('n', '<C-b>', require 'dap'.toggle_breakpoint)

-- Go DAP configuration
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

dap.configurations.go = {
  {
    type = 'delve',
    name = 'Debug',
    request = 'launch',
    program = "${file}"
  },
  {
    type = 'delve',
    name = 'Debug test',
    request = 'launch',
    mode = 'test',
    program = "${file}"
  },
  {
    type = 'delve',
    name = 'Debug test (go.mod)',
    request = 'launch',
    mode = 'test',
    program = "./${relativeFileDirname}"
  }
}
EOF

lua << EOF
require("nvim-dap-virtual-text").setup({
  enabled = false,  -- Disable virtual text by default
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  virt_text_pos = 'eol',
})
EOF

lua << EOF
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...
})
EOF

lua << EOF
require("dapui").setup()
EOF

lua << EOF
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
EOF

lua << EOF
local ui = require("dapui")

ui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        "scopes",
      },
      size = 0.25,
      position = "right"
    },
    {
      elements = {
        "breakpoints",
        "console",
      },
      size = 0.3,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
})
EOF

lua << EOF
local dap = require("dap")
local ui = require("dapui")

-- Start debugging session
vim.keymap.set("n", "ds", function()
  dap.continue()
  ui.toggle({})
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set("n", "dl", require("dap.ui.widgets").hover)
vim.keymap.set("n", "dc", dap.continue)
vim.keymap.set("n", "db", dap.toggle_breakpoint)
vim.keymap.set("n", "dn", dap.step_over)
vim.keymap.set("n", "di", dap.step_into)
vim.keymap.set("n", "do", dap.step_out)
vim.keymap.set("n", "dC", function()
  dap.clear_breakpoints()
  require("notify")("Breakpoints cleared", "warn")
end)
 
-- Close debugger and clear breakpoints
vim.keymap.set("n", "de", function()
  dap.clear_breakpoints()
  ui.toggle({})
  dap.terminate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
  require("notify")("Debugger session ended", "warn")
end)

vim.fn.sign_define('DapBreakpoint', { text = '🐞' })
EOF

