vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.number = true

vim.opt.smartindent = true


vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.path:append('**')
vim.opt.directory = os.getenv("HOME") .. "/.vim/swap,."
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.spelllang = 'en_us'
vim.opt.spell = true
vim.opt.complete:append('kspell')
