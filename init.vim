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

Plug 'numToStr/Comment.nvim'

Plug 'folke/which-key.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Debug plugins
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-notify'
Plug 'folke/neodev.nvim'

" Auto close brackets
Plug 'm4xshen/autoclose.nvim'

call plug#end()

" Base settings

" color scheme
" colorscheme tokyonight
set background=dark
colorscheme gruvbox

"lua << EOF
"vim.g.material_style = "deep ocean"
"EOF
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
vim.api.nvim_set_keymap('n', '<C-a>', ':q!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<C-a>', ':q!<CR>', {noremap = true, silent = true})
EOF

lua << EOF
vim.api.nvim_set_keymap("n", "r", "vim.lsp.buf.rename", {noremap = true})
vim.api.nvim_set_keymap("v", "r", "vim.lsp.buf.rename", {noremap = true})
EOF

" Copy and paste in special clipboard
lua << EOF
-- Copy
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true})

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
       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-R>+<Esc>", true, true, true), "n", true)
   else
       vim.api.nvim_put({content}, "c", true, true)
   end
end

-- Bind Ctrl+V to the paste_from_clipboard function in normal, visual, and insert mode
vim.api.nvim_set_keymap("n", "<C-v>", ":lua paste_from_clipboard()<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "<C-v>", ":lua paste_from_clipboard()<CR>", {noremap = true})
vim.api.nvim_set_keymap("i", "<C-v>", "<Esc>:lua paste_from_clipboard()<CR>a", {noremap = true})
EOF

" Close tab in tabbuffer
lua << EOF
vim.api.nvim_set_keymap('n', '<F5>', ':bdelete<CR>:bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<F5>', ':bdelete<CR>:bnext<CR>', { noremap = true, silent = true })
EOF

autocmd FileType python set colorcolumn=100
" Plugin settings
lua << EOF
-- Telescope shorcuts
vim.api.nvim_set_keymap("!", "<F4>", ":Telescope find_files<cr>", { noremap = true})
vim.api.nvim_set_keymap("!", "<F2>", ":Telescope live_grep<cr>", { noremap = true})
vim.api.nvim_set_keymap("n", "<F4>", ":Telescope find_files<cr>", { noremap = true})
vim.api.nvim_set_keymap("n", "<F2>", ":Telescope live_grep<cr>", { noremap = true})
vim.api.nvim_set_keymap("n", "<F3>", ":Telescope buffers<cr>", { noremap = true})
vim.api.nvim_set_keymap("!", "<F3>", ":Telescope buffers<cr>", { noremap = true})

-- Tree shocuts
vim.api.nvim_set_keymap("!", "<C-n>", ":NvimTreeToggle<cr>", { noremap = true})
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<cr>", { noremap = true})

-- Buffer line shortcuts
-- Movement
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "o", ":BufferLineCyclePrev<cr>", {noremap = true})

-- Actions
vim.api.nvim_set_keymap("n", "<C-k>", ":BufferLineCloseOthers<cr>", {noremap = true})
vim.api.nvim_set_keymap("!", "<C-k>", ":BufferLineCloseOthers<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-r>", ":BufferLineCloseRight<cr>", {noremap = true})
vim.api.nvim_set_keymap("!", "<C-r>", ":BufferLineClosseRight<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCloseLeft<cr>", {noremap = true})
vim.api.nvim_set_keymap("!", "<C-l>", ":BufferLineCLoseLeft<cr>", {noremap = true})

-- Gitsigns
vim.api.nvim_set_keymap("n", "<F1>", ":Gitsigns blame_line<cr>", {noremap = true})
vim.api.nvim_set_keymap("!", "<F1>", ":Gitsigns blame_line<cr>", {noremap = true})

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
require'lspconfig'.pyright.setup{}
-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}


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
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },

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
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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

  -- Set up lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
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
    width = 30,
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
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}}, -- | "center" | "right"}},
    color_icons = true, -- | false, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- | false, -- disable filetype icons for buffers
    show_buffer_close_icons = true, -- | false,
    show_close_icon = true, -- | false,
    show_tab_indicators = true, -- | false,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant", -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true -- | false,
  }
}
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
  width = 40,
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
  highlight_git = false,
  full_name = false,
  highlight_opened_files = "none",
  highlight_modified = "none",
  root_folder_label = ":~:s?$?/..?",
  indent_width = 2,
  indent_markers = {
    enable = false,
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
  git_ignored = true,
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
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
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
  yadm = {
    enable = false
  },
}
EOF

lua << EOF
require("ibl").setup {
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
EOF

lua << EOF
require("nvim-dap-virtual-text").setup()
EOF

lua << EOF
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...
})
EOF

lua << EOF
require("dapui").setup()
require("dapui").open()
require("dapui").close()
require("dapui").toggle()
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

