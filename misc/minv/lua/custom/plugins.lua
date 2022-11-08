--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.setup_plugins(minv)
    local is_vscode = vim.g.vscode ~= nil
    local req = require
    minv.presets.treesitter.highlight.enable = not is_vscode
    minv:update_plugins({
        treesitter = {[1] = {
            ts_autotag = {
                [1] = "windwp/nvim-ts-autotag",
                after = {"$setup_treesitter"},
                setup = function()
                    req("nvim-treesitter.configs").define_modules({autotag = {enable = true}})
                end
            },
            vim_matchup = {
                [1] = "andymass/vim-matchup",
                after = {"$setup_treesitter"},
                setup = function()
                    req("nvim-treesitter.configs").define_modules({matchup = {enable = true}})
                end
            },
            ts_rainbow = {
                [1] = "p00f/nvim-ts-rainbow",
                start = false,
                disable = is_vscode,
                after = {"$setup_treesitter"},
                setup = function()
                    req("nvim-treesitter.configs").define_modules({rainbow = {enable = true, extended_mode = true}})
                end
            }
        }},
        cmp = {
            [1] = {
                ["$pre_setup_cmp"] = {setup = function()
                    local compare = req("cmp").config.compare
                    minv:update_preset({cmp = {sorting = {comparators = {["$set"] = {compare.recently_used, compare.score, compare.sort_text}}}, sources = {["$concat"] = {{name = "nvim_lsp_signature_help"}}}}})
                end},
                autopairs = {
                    [1] = "windwp/nvim-autopairs",
                    after = {"$setup_cmp"},
                    setup = function()
                        require("custom.autopairs").setup()
                    end
                },
                cmp_lsp_signature_help = {[1] = "hrsh7th/cmp-nvim-lsp-signature-help"}
            },
            disable = is_vscode,
            start = false
        },
        ui = {
            [1] = {
                ["$pre_setup_gitsigns"] = {setup = function()
                    minv:update_keybindings({["git.extra"] = {["$merge"] = {["<Leader>gd"] = {cmd = "<Cmd>DiffviewOpen<CR>", desc = "Open diffview"}, ["<Leader>gg"] = {cmd = "<Cmd>Neogit kind=split<CR>", desc = "Open neogit"}}}})
                end},
                ["$pre_setup_telescope"] = {setup = function()
                    minv:update_keybindings({["telescope.extra"] = {["$merge"] = {["<Leader>fn"] = {cmd = "<Cmd>Telescope notify<CR>", desc = "Search notifications"}, ["<Leader>ft"] = {cmd = "<Cmd>TodoTelescope<CR>", desc = "Search TODOs"}, ["<Leader>fp"] = {cmd = "<Cmd>Telescope projects<CR>", desc = "Search recent projects"}, ["<Leader>fP"] = {cmd = "<Cmd>SessionManager load_session<CR>", desc = "Search recent sessions"}}}})
                end},
                ["$pre_setup_alpha"] = {setup = function()
                    minv:update_preset({alpha = {buttons = {["$batch"] = {{["$insert"] = {2, {"s", "  Last Session", "<Cmd>SessionManager load_last_session<CR>"}}}, {["$insert"] = {4, {"p", "  Recent Projects", "<Cmd>Telescope projects<CR>"}}}}}}})
                end},
                ["$pre_setup_bufferline"] = {setup = function()
                    minv:update_keybindings({["bufferline.extra"] = {["$merge"] = {["<Leader>x"] = {cmd = "<Cmd>Bdelete<CR>", desc = "Close buffer"}}}})
                    minv:update_preset({bufferline = {options = {
                        close_command = {["$set"] = "Bdelete! %d"},
                        right_mouse_command = {["$set"] = "Bdelete! %d"},
                        diagnostics_indicator = {["$set"] = function(_1, _2, diag)
                            if diag.error ~= nil then
                                return ("(" .. tostring(diag.error)) .. ")"
                            else
                                return ""
                            end
                        end}
                    }}})
                end},
                ["$pre_setup_lualine"] = {setup = function()
                    minv:update_preset({lualine = {options = {component_separators = {["$set"] = {left = "", right = ""}}, section_separators = {["$set"] = {left = "", right = ""}}}}})
                end},
                numb = {
                    [1] = "nacro90/numb.nvim",
                    setup = function()
                        req("numb").setup({})
                    end
                },
                bufdelete = {[1] = "famiu/bufdelete.nvim", disable = is_vscode},
                bqf = {
                    [1] = "kevinhwang91/nvim-bqf",
                    setup = function()
                        req("bqf").setup({func_map = {pscrollup = "<C-u>", pscrolldown = "<C-d>"}})
                    end
                },
                todo_comments = {
                    [1] = "folke/todo-comments.nvim",
                    setup = function()
                        req("todo-comments").setup({})
                    end
                },
                nvim_colorizer = {
                    [1] = "norcalli/nvim-colorizer.lua",
                    setup = function()
                        req("colorizer").setup({"*"})
                    end
                },
                nvim_notify = {
                    [1] = "rcarriga/nvim-notify",
                    setup = function()
                        local notify = req("notify")
                        notify.setup({max_width = 70})
                        vim.notify = notify
                        req("telescope").load_extension("notify")
                    end
                },
                fidget = {
                    [1] = "j-hui/fidget.nvim",
                    setup = function()
                        req("fidget").setup({})
                    end
                },
                indent_blankline = {
                    [1] = "lukas-reineke/indent-blankline.nvim",
                    after = {"$setup_nightfox"},
                    setup = function()
                        local colors = req("nightfox.palette").load(minv.presets.nightfox_style)
                        local Shade = req("nightfox.lib.shade")
                        local fg = Shade.new(colors.comment, -0.1, -0.5)
                        vim.api.nvim_set_hl(0, "IndentBlanklineChar", {fg = fg.dim})
                        vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", {fg = fg.base})
                        req("indent_blankline").setup({
                            char = "▏",
                            context_char = "▏",
                            filetype_exclude = {
                                "alpha",
                                "NvimTree",
                                "",
                                "help",
                                "lspinfo",
                                "toggleterm",
                                "packer"
                            },
                            show_current_context = true,
                            use_treesitter = true,
                            show_first_indent_level = false
                        })
                    end
                },
                dressing = {
                    [1] = "stevearc/dressing.nvim",
                    setup = function()
                        req("dressing").setup({})
                    end
                },
                neogit = {
                    [1] = "TimUntersberger/neogit",
                    setup = function()
                        req("neogit").setup({integrations = {diffview = true}})
                    end
                },
                diffview = {
                    [1] = "sindrets/diffview.nvim",
                    setup = function()
                        local actions = req("diffview.config").actions
                        req("diffview").setup({enhanced_diff_hl = true, file_panel = {win_config = {width = 30}}, key_bindings = {view = {q = "<Cmd>DiffviewClose<CR>", ["<C-b>"] = actions.toggle_files, ["<C-n>"] = actions.focus_files}, file_panel = {q = "<Cmd>DiffviewClose<CR>", ["<C-b>"] = actions.toggle_files, ["<C-n>"] = actions.focus_files}, file_history_panel = {q = "<Cmd>DiffviewClose<CR>", ["<C-b>"] = actions.toggle_files, ["<C-n>"] = actions.focus_files}}})
                    end
                }
            },
            disable = is_vscode,
            start = false
        },
        extra = {[1] = {
            ["repeat"] = {[1] = "tpope/vim-repeat"},
            sleuth = {[1] = "tpope/vim-sleuth"},
            leap = {
                [1] = "ggandor/leap.nvim",
                setup = function()
                    local hi_primary = {link = "MatchParen"}
                    local hi_backdrop = {link = "Comment"}
                    if is_vscode then
                        hi_primary = {fg = "#d19a66"}
                        hi_backdrop = {fg = "#7f848e"}
                    end
                    vim.api.nvim_set_hl(0, "LeapLabelPrimary", hi_primary)
                    vim.api.nvim_set_hl(0, "LeapBackdrop", hi_backdrop)
                    req("leap").set_default_keymaps()
                end
            },
            project = {
                [1] = "ahmedkhalf/project.nvim",
                disable = is_vscode,
                start = false,
                setup = function()
                    req("project_nvim").setup({ignore_lsp = {"null-ls"}})
                    req("telescope").load_extension("projects")
                end
            },
            session_manager = {
                [1] = "Shatur/neovim-session-manager",
                disable = is_vscode,
                start = false,
                setup = function()
                    local cfg = req("session_manager.config")
                    req("session_manager").setup({autoload_mode = cfg.AutoloadMode.Disabled})
                end
            }
        }}
    })
end
return ____exports
