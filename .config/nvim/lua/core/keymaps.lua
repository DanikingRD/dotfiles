vim.g.mapleader = ' ';
-- local keymap = vim.keymap;
vim.api.nvim_create_user_command('W', ':w', {});
vim.api.nvim_create_user_command('Q', ':q', {});

-- keybind for ToggleTerm
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true });
