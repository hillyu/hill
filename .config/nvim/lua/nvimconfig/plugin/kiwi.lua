return
{
    'serenevoid/kiwi.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    opts = {
        {
            name = "wiki",
            path = "~/vimwiki"
        },
        {
            name = "website",
            path = "~/website/hugo/everstream/content/posts/"
        }
    },
    keys = {
        { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
        { "<leader>wp", ":lua require(\"kiwi\").open_wiki_index(\"wiki\")<cr>", desc = "Open index of personal wiki" },
        { "T", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
    },
    lazy = true
}
