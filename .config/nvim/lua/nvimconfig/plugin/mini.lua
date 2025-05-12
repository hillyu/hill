return {
    { 'echasnovski/mini.surround', version = false, config=true },
    { 'echasnovski/mini.ai', version = false, config=true },
    { 'echasnovski/mini.comment', version = false, config=true },
    { 'echasnovski/mini.pairs', version = false, config=true },
    { 'echasnovski/mini.splitjoin', version = false, config=true },
    { 'echasnovski/mini.operators', version = false, config=true },
    { 'echasnovski/mini.bracketed', version = false, config=true },
    { 'echasnovski/mini-git', version = false, main = 'mini.git', config=true },
    { 'echasnovski/mini.diff', version = false, config=true },
    { 'echasnovski/mini.statusline', version = false, config=true },
    { 'echasnovski/mini.icons', version = false, config=true },
    { 'echasnovski/mini.cursorword', version = false, config=true },
    { 'echasnovski/mini.indentscope', version = false, config=true },
    { 'echasnovski/mini.trailspace', version = false, opts = {},
        config = function()
            require('mini.trailspace').setup({})
            vim.keymap.set('n','<leader>ts', MiniTrailspace.trim)
            vim.keymap.set('n','<leader>tl', MiniTrailspace.trim_last_lines)
        end
    },
    { 'echasnovski/mini.clue', version = false,
        config = function ()
            local miniclue = require('mini.clue')
            miniclue.setup({
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            })
        end,
    },
}

