local utils = require('utils')

local cmd = vim.cmd

vim.g.gruvbox_contrast_dark = 'soft'
vim.g.gruvbox_bold = '1'
vim.g.gruvbox_invert_selection = '0'
cmd 'colorscheme gruvbox'

-- vim.api.nvim_exec([[
--     augroup Linting
--       autocmd!
--       autocmd FileType javascript setlocal makeprg=eslint -c /home/skoiv/Projects/impulss/reactui/ui/.eslintrc.js
--       autocmd BufWritePost *.tsx silent make! <afile> | silent redraw!
--       autocmd QuickFixCmdPost [^l]* cwindow
--     augroup END
-- ]], false)

-- vim.api.nvim_exec([[
--     hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--     hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--     hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsDefaultError cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsDefaultWarning cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsDefaultInformation cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsDefaultHint cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsVirtualTextError cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsVirtualTextWarning cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsVirtualTextInformation cterm=bold ctermbg=red guibg=LightYellow
--     hi LspDiagnosticsVirtualTextHint cterm=bold ctermbg=red guibg=LightYellow
-- ]], false)
