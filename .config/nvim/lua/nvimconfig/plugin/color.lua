return {
    {
        'maxmx03/solarized.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark' -- or 'light'
            require('solarized').setup({
                transparent = true, -- enable transparent background
                highlights = function (c, colorhelper)
                    return {
                        Visual = { bg = c.base3 },
                        SpellBad = { undercurl = true }
                    }
                end
            })
            vim.cmd.colorscheme 'solarized'
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
            -- vim.cmd.colorscheme 'tokyonight'
        end
    },
}
