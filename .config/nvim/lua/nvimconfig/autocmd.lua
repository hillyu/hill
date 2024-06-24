vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
    command = "set relativenumber",
})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
    command = "set norelativenumber",
})
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function() vim.fn.system("yank.sh", vim.v.event.regcontents) end,
})
