local utils = require('utils')
local nvim_lsp = require('lspconfig')
local cmd = vim.cmd

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

--[[--------------------------------]]
--[[ OPTIONS                      --]]
--[[--------------------------------]]
cmd 'syntax enable'
utils.opt('w', 'colorcolumn', '100')
utils.opt('w', 'scrolloff', 5)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'number', true)
utils.opt('w', 'signcolumn', 'yes')
utils.opt('o', 'wildmode', 'full')
utils.opt('o', 'wildignore', '**/node_modules/**')
-- Search should be case sensitive
utils.opt('o', 'smartcase', true)
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
--[[ DADBOD CONFIGURATION         --]]
--[[--------------------------------]]
vim.g.impulssdb = 'postgres://localhost:5432/impulssdb'
--[[--------------------------------]]
--[[ LSP CONFIGURATION            --]]
--[[--------------------------------]]
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 4,
    },
    signs = function(bufnr, _)
      local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
      if not ok then
        return true
      end
      return result
    end,
    update_in_insert = false,
  }
)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end

local servers = { "tsserver", "jdtls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

local sumneko_root_path = '/home/skoiv/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        -- path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
--[[--------------------------------]]
--[[ ALE CONFIGURATION            --]]
--[[--------------------------------]]
vim.g.ale_set_highlights = 0
--[[--------------------------------]]
--[[ COMPE                        --]]
--[[--------------------------------]]
utils.opt('o', 'completeopt', 'menuone,noselect')
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

utils.map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
utils.map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
utils.map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
utils.map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--[[--------------------------------]]
--[[ CUSTOM                       --]]
--[[--------------------------------]]
function _G.tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end
function _G.s_tab()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab()', {expr = true, noremap = true})

function _G.token()
  os.execute("node /home/skoiv/scripts/impulss/auth/index.js")
  os.execute("pm2 restart impulss")
  return true
end

function _G.translate()
  os.execute("lua /home/skoiv/scripts/impulss/translate.lua | jq | xclip -sel clip")
  return true
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  indent = {
    enable = true
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
  }
}
