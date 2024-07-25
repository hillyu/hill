return {
    'huggingface/llm.nvim',
     enabled = function() return jit.arch ~= "arm64" end,
    config = function()
        require('llm').setup({
            -- backend = "openai",
            -- api_token = "sk-551f5b59df1544b196edc5005248a730",
            -- model = "deepseek-coder",
            -- url = "https://api.deepseek.com",
            -- disable_url_path_completion = true,
            -- backend = "ollama",
            -- url = "http://192.168.8.2:11434", -- llm-ls uses "/api/generate"
            -- url = "http://localhost:11434", -- llm-ls uses "/api/generate"

            backend = "huggingface",
            api_token = "REMOVED_TOKEN",
            model = "bigcode/starcoder2-15b", -- the model ID, behavior depends on backend
            tokens_to_clear = { "<|endoftext|>" }, -- tokens to remove from the model's output
            -- set this if the model supports fill in the middle
            fim = {
                enabled = true,
                prefix = "<fim_prefix>",
                middle = "<fim_middle>",
                suffix = "<fim_suffix>",
            },
            debounce_ms = 150,
            -- url = "http://localhost:11434", -- llm-ls uses "/api/generate"

            -- model = "starcoder2:3b",
            -- model = "codegemma:2b",

            -- tokens_to_clear = { "<|endoftext|>" },
            -- fim = {
            --     enabled = true,
            --     prefix = "<|fim_prefix|>",
            --     middle = "<|fim_middle|>",
            --     suffix = "<|fim_suffix|>",
            -- },
            -- fim = {
            --     enabled = true,
            --     prefix = "<fim_prefix>",
            --     middle = "<fim_middle>",
            --     suffix = "<fim_suffix>",
            -- },
            -- context_window = 8192,
            tokenizer = {
                repository = "bigcode/starcoder2-3b",
                -- repository = "google/gemma-2b",
                
            },
            -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
            request_body = {
                --     -- Modelfile options for the model you use
                options = {
                    temperature = 0.2,
                    max_new_tokens = 60,
                    top_p = 0.95,
                }
            },
            accept_keymap = "<C-E>",
        })
    end,
}
