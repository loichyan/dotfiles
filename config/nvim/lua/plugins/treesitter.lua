return {
  {
    "nvim-treesitter",
    dependencies = { "windwp/nvim-ts-autotag", "andymass/vim-matchup" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "dart",
        "diff",
        "dockerfile",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "help",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      autotag = { enable = true },
      highlight = { additional_vim_regex_highlighting = false },
      matchup = { enable = true },
    },
  },
}
