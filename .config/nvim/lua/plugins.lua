return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'editorconfig/editorconfig-vim'}
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
  use {'honza/vim-snippets'}
  use {'gruvbox-community/gruvbox'}
  use {'hrsh7th/nvim-compe'}
  use {'justinmk/vim-dirvish'}
  use {'tpope/vim-dadbod'}
end)
