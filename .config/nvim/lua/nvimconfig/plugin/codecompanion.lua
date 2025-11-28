return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts= {
        strategies = {
            chat = {
                adapter = "gemini_cli",
            },
            inline = {
                adapter = "litellm",
            },
            cmd = {
                adapter = "litellm",
            },
        },
        adapters = {
            http = {
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
        },
    }
}
