return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim',       opts = {} },
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
            local servers = {
                lua_ls = {
                    -- cmd = { ... },
                    -- filetypes = { ... },
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            telemetry = {
                                enable = false
                            },
                            -- below is no longer needed as it is handled by lazydev.
                            -- diagnostics = {
                            --     -- Get the language server to recognize the `vim` global
                            --     globals = {'vim'},
                            --     disable = { 'missing-fields' }
                            -- },
                            -- runtime = { version = 'LuaJIT' },
                            -- workspace = {
                            --     checkThirdParty = false,
                            --     -- Tells lua_ls where to find all the Lua files that you have loaded
                            --     -- for your neovim configuration.
                            --     library = {
                            --         '${3rd}/luv/library',
                            --         unpack(vim.api.nvim_get_runtime_file('', true)),
                            --     },
                            --     -- If lua_ls is really slow on your computer, you can try this instead:
                            --     -- library = { vim.env.VIMRUNTIME },
                            -- },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend('force', {}, lsp_capabilities,
                            server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end
                },
            })
            -- keybindings autocmd
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('K', vim.lsp.buf.hover, '[H]over')
                    -- Rename the variable under your cursor.
                    --  Most Language Servers support renaming across files, etc.
                    map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map('<leader>ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                    -- Find references for the word under your cursor.
                    map('<leader>gr', vim.lsp.buf.references, '[G]oto [R]eferences')

                    -- Jump to the implementation of the word under your cursor.
                    --  Useful when your language has ways of declaring types without an actual implementation.
                    map('<leader>gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map('<leader>gl', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    map('<leader>sh', vim.lsp.buf.signature_help, 'Open Signature Help')

                    -- autoformat already have a abstract method for this
                    -- map('<leader>cf', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', 'Format Code')

                    -- Jump to the type of the word under your cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
                end
            })
        end
    },

    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
}
