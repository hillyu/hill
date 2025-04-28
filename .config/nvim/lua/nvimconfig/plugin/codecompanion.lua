return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "litellm",
                },
                inline = {
                    adapter = "litellm",
                },
                cmd = {
                    adapter = "litellm",
                },
            },
            adapters = {
                litellm = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        schema = {
                            model = {
                                default = "gemini-2.5-pro",
                            },
                        },
                        env = {
                            url = "http://g.ps.ai:12000",
                            api_key = "hillyu",
                        },
                    })
                end,
            },
        })
    end,
}
