local keymap = vim.keymap.set

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Открыть список диагностик' })
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Выйти из терминального режима' })

keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Фокус влево' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Фокус вправо' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Фокус вниз' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Фокус вверх' })
