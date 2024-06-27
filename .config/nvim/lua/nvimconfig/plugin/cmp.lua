
return {
    'onsails/lspkind.nvim',
    {"hrsh7th/nvim-cmp",
        config = function()
            local cmp = require('cmp')
            local luasnip = require("luasnip")
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_snipmate').lazy_load()
            cmp.setup({
                sources = {
                    {name = 'nvim_lsp'},
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                    { name = 'buffer' },
                    { name = 'path' },
                }, 
                mapping = {
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                luasnip.setup({
                    -- Required to automatically include base snippets, like "c" snippets for "cpp"
                    -- load_ft_func = require('luasnip_snippets.common.snip_utils').load_ft_func,
                    -- ft_func = require('luasnip_snippets.common.snip_utils').ft_func,
                    -- To enable auto expansin
                    -- enable_autosnippets = true,
                    -- Uncomment to enable visual snippets triggered using <c-x>
                    -- store_selection_keys = '<c-x>',
                }),
                window = {
                    -- completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },

            })
            -- `/` cmdline setup.
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        {
                            name = 'cmdline',
                            option = {
                                ignore_cmds = { 'Man', '!' }
                            }
                        }
                    })
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        dependencies = {"honza/vim-snippets"},

    },
    'saadparwaiz1/cmp_luasnip',
    -- {
    --     'mireq/luasnip-snippets',
    --     dependencies = {'L3MON4D3/LuaSnip'},
    --     init = function()
    --         -- Mandatory setup function
    --         require('luasnip_snippets.common.snip_utils').setup()
    --     end
    --
    -- },
    "rafamadriz/friendly-snippets", 
    "honza/vim-snippets",
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    "hrsh7th/cmp-nvim-lsp",
}
