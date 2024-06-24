return {
    'huggingface/llm.nvim',
    config = function()
        require('llm').setup({
            backend = "ollama",
            -- api_token = "sk-551f5b59df1544b196edc5005248a730",
            -- model = "deepseek-coder",
            -- url = "https://api.deepseek.com",
            -- disable_url_path_completion = true,
            url = "http://localhost:11434", -- llm-ls uses "/api/generate"
            model = "starcoder2:3b",

            tokens_to_clear = { "<|endoftext|>" },
            fim = {
                enabled = true,
                prefix = "<fim_prefix>",
                middle = "<fim_middle>",
                suffix = "<fim_suffix>",
            },
            context_window = 8192,
            tokenizer = {
                repository = "bigcode/starcoder2-3b",
            },
            -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
            request_body = {
                --     -- Modelfile options for the model you use
                options = {
                    temperature = 0.2,
                    top_p = 0.95,
                }
            },
        })
    end,
}
