if not status is-interactive
    return
end

# Disable greeting
set -g fish_greeting

# Make cursor distinct among modes
set -g fish_vi_force_cursor 1
set -g fish_cursor_default block
set -g fish_cursor_insert line blink
set -g fish_cursor_replace_one underscore
set -g fish_cursor_replace underscore
set -g fish_cursor_external line blink
set -g fish_cursor_visual block

# Theme colors
set -g fish_color_normal normal
set -g fish_color_command green
set -g fish_color_keyword magenta
set -g fish_color_quote yellow
set -g fish_color_redirection magenta
set -g fish_color_end magenta
set -g fish_color_error red -o
set -g fish_color_param normal
set -g fish_color_comment brblack
set -g fish_color_match brblue
set -g fish_color_selection -b brblack
set -g fish_color_search_match -b brblack
set -g fish_color_history_current -o
set -g fish_color_operator brblue
set -g fish_color_escape brblue
set -g fish_color_cwd cyan
set -g fish_color_cwd_root red
set -g fish_color_option cyan
set -g fish_color_valid_path magenta -u
set -g fish_color_autosuggestion brblack
set -g fish_color_user green
set -g fish_color_user_root red
set -g fish_color_host blue
set -g fish_color_host_remote yellow
set -g fish_color_status red
set -g fish_color_cancel -r -o

# Pager colors
set -g fish_pager_color_background
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow
set -g fish_pager_color_prefix green -o -u
set -g fish_pager_color_progress brwhite -b cyan
set -g fish_pager_color_secondary_background
set -g fish_pager_color_secondary_completion
set -g fish_pager_color_secondary_description
set -g fish_pager_color_secondary_prefix
set -g fish_pager_color_selected_background -b brblack
set -g fish_pager_color_selected_completion
set -g fish_pager_color_selected_description
set -g fish_pager_color_selected_prefix
