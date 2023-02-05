return {
  ----------------
  -- My plugins --
  ----------------
  {
    "ahmedkhalf/project.nvim",
    cond = NOT_VSCODE,
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope").extensions.projects.projects()
        end,
        desc = "Projects",
      },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
  },
}
