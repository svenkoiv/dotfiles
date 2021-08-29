vim.g.mapleader = ','

local fn = vim.fn
local execute = vim.api.nvim_command

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]

require('plugins')
require('options')
require('scripts')
require('colorscheme')

-- For LSP debugging
-- vim.lsp.set_log_level("debug")
