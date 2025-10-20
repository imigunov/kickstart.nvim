return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    local on_attach = function(_, bufnr)
      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
      end

      map('n', 'K', vim.lsp.buf.hover, 'Документация')
      map('n', 'gd', vim.lsp.buf.definition, 'Перейти к определению')
      map('n', 'gD', vim.lsp.buf.declaration, 'Перейти к объявлению')
      map('n', 'gr', vim.lsp.buf.references, 'Список ссылок')
      map('n', 'gI', vim.lsp.buf.implementation, 'Перейти к реализации')
      map('n', '<leader>D', vim.lsp.buf.type_definition, 'Тип символа')
      map('n', '<leader>rn', vim.lsp.buf.rename, 'Переименовать')
      map('n', '<leader>ca', vim.lsp.buf.code_action, 'Действия LSP')
      map('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'Поиск по рабочему пространству')
      map('n', '<leader>wd', vim.diagnostic.open_float, 'Диагностика в окне')
      map('n', '[d', vim.diagnostic.goto_prev, 'Предыдущая диагностика')
      map('n', ']d', vim.diagnostic.goto_next, 'Следующая диагностика')
      map('n', 'gK', vim.lsp.buf.signature_help, 'Подпись функции')
      map('i', '<C-k>', vim.lsp.buf.signature_help, 'Подпись функции')
      map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Добавить папку')
      map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Удалить папку')
      map('n', '<leader>wl', function()
        vim.print(vim.lsp.buf.list_workspace_folders())
      end, 'Список папок')

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        vim.lsp.buf.format()
      end, { desc = 'Форматировать текущий буфер через LSP' })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      'stylua',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          server.on_attach = on_attach
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
