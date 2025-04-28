vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
    group = "NumberToggle",
    callback = function()
        if vim.bo.filetype == 'netrw' then
            vim.cmd 'setlocal norelativenumber'
        else
            vim.cmd 'setlocal relativenumber'
        end
    end,
})

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
    group = "NumberToggle",
    command = "setlocal norelativenumber",
})

-- Keep the TextYankPost autocmd separate
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.fn.system("yank.sh", vim.v.event.regcontents)
    end,
})
