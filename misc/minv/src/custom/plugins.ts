import { MINV } from "minv";
import * as _autopairs from "./autopairs";

export function setup_plugins(this: void, minv: MINV) {
  const is_vscode = vim.g.vscode != undefined;
  const req = require as (this: void, mod: string) => AnyTbl;
  minv.presets.treesitter.highlight.enable = !is_vscode;
  minv.update_plugins({
    treesitter: {
      1: {
        ts_autotag: {
          1: "windwp/nvim-ts-autotag",
          after: ["$setup_treesitter"],
          setup() {
            req("nvim-treesitter.configs").define_modules({
              autotag: { enable: true },
            });
          },
        },
        vim_matchup: {
          1: "andymass/vim-matchup",
          after: ["$setup_treesitter"],
          setup() {
            req("nvim-treesitter.configs").define_modules({
              matchup: { enable: true },
            });
          },
        },
        ts_rainbow: {
          1: "p00f/nvim-ts-rainbow",
          start: false,
          disable: is_vscode,
          after: ["$setup_treesitter"],
          setup() {
            req("nvim-treesitter.configs").define_modules({
              rainbow: { enable: true, extended_mode: true },
            });
          },
        },
      },
    },
    cmp: {
      1: {
        $pre_setup_cmp: {
          setup() {
            minv.update_preset({
              cmp: {
                sources: {
                  $concat: [{ name: "nvim_lsp_signature_help" }],
                },
              },
            });
          },
        },
        autopairs: {
          1: "windwp/nvim-autopairs",
          after: ["$setup_cmp"],
          setup() {
            (require("./autopairs") as typeof _autopairs).setup();
          },
        },
        cmp_lsp_signature_help: {
          1: "hrsh7th/cmp-nvim-lsp-signature-help",
        },
      },
      disable: is_vscode,
      start: false,
    },
    ui: {
      1: {
        $pre_setup_gitsigns: {
          setup() {
            minv.update_keybindings({
              "git.extra": {
                $merge: {
                  "<Leader>gd": {
                    cmd: "<Cmd>DiffviewOpen<CR>",
                    desc: "Open diffview",
                  },
                  "<Leader>gg": {
                    cmd: "<Cmd>Neogit kind=split<CR>",
                    desc: "Open neogit",
                  },
                },
              },
            });
          },
        },
        $pre_setup_telescope: {
          setup() {
            minv.update_keybindings({
              "telescope.extra": {
                $merge: {
                  "<Leader>fn": {
                    cmd: "<Cmd>Telescope notify<CR>",
                    desc: "Search notifications",
                  },
                  "<Leader>ft": {
                    cmd: "<Cmd>TodoTelescope<CR>",
                    desc: "Search TODOs",
                  },
                  "<Leader>fp": {
                    cmd: "<Cmd>Telescope projects<CR>",
                    desc: "Search recent projects",
                  },
                  "<Leader>fP": {
                    cmd: "<Cmd>SessionManager load_session<CR>",
                    desc: "Search recent sessions",
                  },
                },
              },
            });
          },
        },
        $pre_setup_alpha: {
          setup() {
            minv.update_preset({
              alpha: {
                buttons: {
                  $batch: [
                    {
                      $insert: [
                        2,
                        [
                          "s",
                          "  Last Session",
                          "<Cmd>SessionManager load_last_session<CR>",
                        ],
                      ],
                    },
                    {
                      $insert: [
                        4,
                        [
                          "p",
                          "  Recent Projects",
                          "<Cmd>Telescope projects<CR>",
                        ],
                      ],
                    },
                  ],
                },
              },
            });
          },
        },
        $pre_setup_bufferline: {
          setup() {
            minv.update_keybindings({
              "bufferline.extra": {
                $merge: {
                  "<Leader>x": {
                    cmd: "<Cmd>Bdelete<CR>",
                    desc: "Close buffer",
                  },
                },
              },
            });
            minv.update_preset({
              bufferline: {
                options: {
                  close_command: { $set: "Bdelete! %d" },
                  right_mouse_command: { $set: "Bdelete! %d" },
                  diagnostics_indicator: {
                    $set: function (this: void, _1: any, _2: any, diag: any) {
                      if (diag.error != undefined) {
                        return "(" + diag.error + ")";
                      } else {
                        return "";
                      }
                    },
                  },
                },
              },
            });
          },
        },
        $pre_setup_lualine: {
          setup() {
            minv.update_preset({
              lualine: {
                options: {
                  component_separators: {
                    $set: { left: "", right: "" },
                  },
                  section_separators: {
                    $set: { left: "", right: "" },
                  },
                },
              },
            });
          },
        },
        $pre_setup_toggleterm: {
          setup() {
            minv.update_preset({
              toggleterm: {
                direction: { $set: "horizontal" },
              },
            });
          },
        },
        numb: {
          1: "nacro90/numb.nvim",
          setup() {
            req("numb").setup({});
          },
        },
        bufdelete: {
          1: "famiu/bufdelete.nvim",
          disable: is_vscode,
        },
        bqf: {
          1: "kevinhwang91/nvim-bqf",
          setup() {
            req("bqf").setup({
              func_map: {
                pscrollup: "<C-u>",
                pscrolldown: "<C-d>",
              },
            });
          },
        },
        todo_comments: {
          1: "folke/todo-comments.nvim",
          setup() {
            req("todo-comments").setup({});
          },
        },
        nvim_colorizer: {
          1: "norcalli/nvim-colorizer.lua",
          setup() {
            req("colorizer").setup(["*"]);
          },
        },
        nvim_notify: {
          1: "rcarriga/nvim-notify",
          setup() {
            const notify = req("notify");
            notify.setup({ max_width: 70 });
            (vim as any).notify = notify as any;
            req("telescope").load_extension("notify");
          },
        },
        fidget: {
          1: "j-hui/fidget.nvim",
          setup() {
            req("fidget").setup({});
          },
        },
        indent_blankline: {
          1: "lukas-reineke/indent-blankline.nvim",
          after: ["$setup_nightfox"],
          setup() {
            const colors = req("nightfox.palette").load(
              minv.presets.nightfox_style
            );
            const Shade = req("nightfox.lib.shade");
            const fg = Shade.new(colors.comment, -0.1, -0.5);
            vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg: fg.dim });
            vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", {
              fg: fg.base,
            });
            req("indent_blankline").setup({
              char: "▏",
              context_char: "▏",
              filetype_exclude: [
                "alpha",
                "NvimTree",
                "",
                "help",
                "lspinfo",
                "toggleterm",
                "packer",
              ],
              show_current_context: true,
              use_treesitter: true,
              show_first_indent_level: false,
            });
          },
        },
        dressing: {
          1: "stevearc/dressing.nvim",
          setup() {
            req("dressing").setup({});
          },
        },
        neogit: {
          1: "TimUntersberger/neogit",
          setup() {
            req("neogit").setup({
              integrations: {
                diffview: true,
              },
            });
          },
        },
        diffview: {
          1: "sindrets/diffview.nvim",
          setup() {
            const actions = req("diffview.config").actions;
            req("diffview").setup({
              enhanced_diff_hl: true,
              file_panel: {
                win_config: {
                  width: 30,
                },
              },
              key_bindings: {
                view: {
                  ["q"]: "<Cmd>DiffviewClose<CR>",
                  ["<C-b>"]: actions.toggle_files,
                  ["<C-n>"]: actions.focus_files,
                },
                file_panel: {
                  ["q"]: "<Cmd>DiffviewClose<CR>",
                  ["<C-b>"]: actions.toggle_files,
                  ["<C-n>"]: actions.focus_files,
                },
                file_history_panel: {
                  ["q"]: "<Cmd>DiffviewClose<CR>",
                  ["<C-b>"]: actions.toggle_files,
                  ["<C-n>"]: actions.focus_files,
                },
              },
            });
          },
        },
      },
      disable: is_vscode,
      start: false,
    },
    extra: {
      1: {
        // TODO: RRethy/vim-illuminate
        // TODO: glepnir/lspsaga.nvim
        repeat: { 1: "tpope/vim-repeat" },
        sleuth: { 1: "tpope/vim-sleuth" },
        leap: {
          1: "ggandor/leap.nvim",
          setup() {
            let hi_primary = {
              link: "MatchParen",
            } as any;
            let hi_backdrop = {
              link: "Comment",
            } as any;
            if (is_vscode) {
              hi_primary = {
                fg: "#d19a66",
              };
              hi_backdrop = {
                fg: "#7f848e",
              };
            }
            vim.api.nvim_set_hl(0, "LeapLabelPrimary", hi_primary);
            vim.api.nvim_set_hl(0, "LeapBackdrop", hi_backdrop);
            req("leap").set_default_keymaps();
          },
        },
        project: {
          1: "ahmedkhalf/project.nvim",
          disable: is_vscode,
          start: false,
          setup() {
            req("project_nvim").setup({
              ignore_lsp: ["null-ls"],
            });
            req("telescope").load_extension("projects");
          },
        },
        session_manager: {
          1: "Shatur/neovim-session-manager",
          disable: is_vscode,
          start: false,
          setup() {
            const cfg = req("session_manager.config");
            req("session_manager").setup({
              autoload_mode: cfg.AutoloadMode.Disabled,
            });
          },
        },
      },
    },
  });
}
