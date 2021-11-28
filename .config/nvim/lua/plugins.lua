return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'junegunn/fzf'}
  use {'junegunn/fzf.vim'}
  use {'neovim/nvim-lspconfig'}
  use {'sheerun/vim-polyglot'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-unimpaired'}
  use {'tpope/vim-eunuch'}
  use {'vimwiki/vimwiki'}
  use {'dense-analysis/ale'}
  use {'gruvbox-community/gruvbox'}
  use {'mfussenegger/nvim-jdtls'}
  use {'nvim-treesitter/nvim-treesitter'}
  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons', opt = true}
  -- }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'rafamadriz/friendly-snippets'
    }
  }
  use {'justinmk/vim-dirvish'}
  use {'tpope/vim-dadbod'}
end)
