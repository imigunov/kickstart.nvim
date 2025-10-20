local group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  desc = 'Подсветка скопированного текста',
  callback = function()
    vim.hl.on_yank()
  end,
})
