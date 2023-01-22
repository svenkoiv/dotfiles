local utils = require('utils')
local nvim_lsp = require('lspconfig')

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

--[[--------------------------------]]
--[[ CMP                          --]]
--[[--------------------------------]]
utils.opt('o', 'completeopt', 'menu,menuone,noselect')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })
})

-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

--[[--------------------------------]]
--[[ LSP                          --]]
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

local buf_options = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', buf_options)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', buf_options)
  vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', buf_options)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', buf_options)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", buf_options)
  end
end

local on_attach_java = function(client, bufnr)
  on_attach(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', "<cmd>lua require('jdtls').code_action()<CR>", buf_options)
end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "tsserver", "pyright" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    -- capabilities = capabilities,
  }
end

nvim_lsp["jdtls"].setup {
  on_attach = on_attach_java,
  cmd = {
    "/usr/lib/jvm/java-11-openjdk/bin/java",
    "-javaagent:/usr/local/share/lombok/lombok.jar",
    "-Xbootclasspath/a:/usr/local/share/lombok/lombok.jar",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-Xmx2G",
    "-jar", "/home/skoiv/lsp/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.100.v20201223-0822.jar",
    "-configuration", "/home/skoiv/lsp/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux",
    "-data", "/home/skoiv/workspace",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED"
  },
}

require'lspconfig'.eslint.setup{}
require'lspconfig'.tailwindcss.setup{}
