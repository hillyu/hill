return {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    {"williamboman/mason-lspconfig.nvim",
        config = function()
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            local default_setup = function(server)
                require('lspconfig')[server].setup({
                    capabilities = lsp_capabilities,
                })
            end
            local lua_ls = function()
                require('lspconfig').lua_ls.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT'
                            },
                            diagnostics = {
                                globals = {'vim'},
                            },
                            workspace = {
                                library = {
                                    vim.env.VIMRUNTIME,
                                }
                            }
                        }
                    }
                })
            end

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    default_setup,
                },
            })
        end
    }
}
