local utils = require('utils')

--[[--------------------------------]]
--[[ OPTIONS                      --]]
--[[--------------------------------]]
vim.cmd 'syntax enable'
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
vim.g.airportdb = 'postgres://airport_app:test@localhost:5432/airport'
