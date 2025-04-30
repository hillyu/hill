return {
    { 'echasnovski/mini.surround', version = false },
    { 'echasnovski/mini.ai', version = false },
    { 'echasnovski/mini.indentscope', version = false },
    { 'echasnovski/mini.trailspace', version = false },
    { 'echasnovski/mini.icons', version = false },
    { 'echasnovski/mini.clue', version = false, opts = {
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
    }
    },
}

