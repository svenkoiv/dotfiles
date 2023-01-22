local utils = require('utils')

--[[--------------------------------]]
--[[ OPTIONS                      --]]
--[[--------------------------------]]
vim.cmd 'syntax enable'
vim.cmd 'set noswapfile'
utils.opt('w', 'colorcolumn', '100')
utils.opt('w', 'scrolloff', 5)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'number', true)
utils.opt('w', 'signcolumn', 'yes')
utils.opt('o', 'wildmode', 'full')
utils.opt('o', 'wildignore', '**/node_modules/**')
-- Search should be case sensitive
utils.opt('o', 'smartcase', true)
utils.opt('o', 'clipboard', 'unnamedplus')
--[[ Should be possible to open buffers without saving current buffer.
(E37: No write since last change). --]]
utils.opt('o', 'hidden', true)
--[[ Determines the maximum number of items to show in the popup menu for
'Insert' mode completion. --]]
utils.opt('o', 'pumheight', 7)
--[[ Discourage usage of arrow keys --]]
utils.map('n', '<up>', '');
utils.map('n', '<down>', '');
utils.map('n', '<left>', '');
utils.map('n', '<right>', '');
utils.map('i', '<up>', '');
utils.map('i', '<down>', '');
utils.map('i', '<left>', '');
utils.map('i', '<right>', '');
utils.map('', 'Q', '')
utils.map('n', '<leader>ev', ':edit $MYVIMRC<cr>', { silent = true, noremap = true })

--[[--------------------------------]]
--[[ FZF CONFIGURATION            --]]
--[[--------------------------------]]
utils.map('n', '<leader>o', ':Files<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>O', ':Files!<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>b', ':Buffers<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>B', ':Buffers!<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>l', ':Lines<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>h:', ':History:<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>h/', ':History/<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>c', ':Commands<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>m', ':Marks<cr>', { silent = true, noremap = true })

--[[--------------------------------]]
--[[ DIRVISH CONFIGURATION        --]]
--[[--------------------------------]]
utils.map('n', '<leader>ft', ':Dirvish<cr>', { silent = true, noremap = true })
utils.map('n', '<leader>ff', ':Dirvish %<cr>', { silent = true, noremap = true })

--[[--------------------------------]]
--[[ ALE CONFIGURATION            --]]
--[[--------------------------------]]
vim.g.ale_set_highlights = 0

--[[--------------------------------]]
--[[ DADBOD CONFIGURATION         --]]
--[[--------------------------------]]
vim.g.impulssdb = 'postgres://localhost:5432/impulssdb'
vim.g.aesdb = 'postgres://localhost:5432/aesdb'

--[[--------------------------------]]
--[[ VSNIP CONFIGURATION          --]]
--[[--------------------------------]]
vim.g.vsnip_snippet_dir=vim.fn.stdpath('config') .. '/snippets'
utils.map('n', '<leader>es', ':VsnipOpen<cr>', { silent = true, noremap = true })

--[[--------------------------------]]
--[[ LUALINE CONFIGURATION        --]]
--[[--------------------------------]]
-- require'nvim-web-devicons'.setup{}
-- require'lualine'.setup{
--   options = { theme  = 'gruvbox' },
-- }

require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages }
  ensure_installed = { "typescript" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = false,              -- false will disable the whole extension
  },
  indent = {
    enable = true,
  },
}

--[[--------------------------------]]
--[[ SESSIONS CONFIGURATION       --]]
--[[--------------------------------]]
-- utils.map('n', '<leader>mks', ':Marks<cr>', { silent = true, noremap = true })
-- utils.map('n', '<leader>ss', ':mks! ~/.vim-sessions/.vim<left><left><left><left>', { silent = false, noremap = true })
-- utils.map('n', '<leader>sr', ':so ~/.vim-sessions/', { silent = false, noremap = true })
--
