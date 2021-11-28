local cmd = vim.cmd


vim.g.gruvbox_contrast_dark = 'soft'
vim.g.gruvbox_bold = '1'
vim.g.gruvbox_invert_selection = '0'
cmd 'colorscheme gruvbox'

-- Transparant background
-- vim.api.nvim_exec([[
--     hi Normal ctermbg=NONE
--     hi NonText ctermbg=NONE
-- ]], false)
