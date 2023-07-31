return {
  {
    "nvim-treesitter",
    dependencies = { "windwp/nvim-ts-autotag", "andymass/vim-matchup" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "cue",
        "dart",
        "diff",
        "dockerfile",
        "fish",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "haskell",
        "html",
        "latex",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "perl",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      autotag = { enable = true },
      highlight = { enable = NOT_VSCODE, additional_vim_regex_highlighting = false },
      matchup = { enable = true },
    },
  },
}
