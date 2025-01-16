vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.number = true
vim.opt.showmode = false

vim.opt.smartindent = true


vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.path:append '**'
vim.opt.directory = os.getenv("HOME") .. "/.vim/swap,."
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.termguicolors = false

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.spelllang = 'en_us'
vim.opt.spell = true
vim.opt.complete:append('kspell')

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
-- vim.g.netrw_preview = 1
vim.g.netrw_keepdir = 1

-- vim.cmd.colorscheme  'tokyonight'
vim.cmd.colorscheme  'catppuccin-frappe'

