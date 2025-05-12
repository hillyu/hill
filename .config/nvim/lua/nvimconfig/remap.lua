vim.g.mapleader = " "
vim.keymap.set("n", "<leader>f", vim.cmd.Lexplore, { desc = "Open Finder in side bar." })
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = "Open Finder in side bar." })
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = "Open Finder in side bar." })
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = "Open Finder in side bar." })
-- borrowed from internet
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>y", ':call system("yank.sh", @")<cr> :echom "clipboard sync complete"<cr>')
vim.keymap.set("n", "<leader>ev", ':cd ~/.config/nvim/lua/nvimconfig/| :Lex<cr>', { silent = true })
vim.keymap.set("n", "<leader>sv", function() vim.cmd("so") end)
-- vnnoremap <leader>s a<C-X><C-S>
-- TODO: vimwiki stuff
