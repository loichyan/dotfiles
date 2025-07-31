if status is-interactive
    set -g fish_color_normal normal
    set -g fish_color_command green
    set -g fish_color_keyword magenta
    set -g fish_color_quote yellow
    set -g fish_color_redirection magenta
    set -g fish_color_end magenta
    set -g fish_color_error red -o
    set -g fish_color_param normal
    set -g fish_color_valid_path magenta -u
    set -g fish_color_option cyan
    set -g fish_color_comment brblack
    set -g fish_color_selection brwhite -b brblack
    set -g fish_color_operator brblue
    set -g fish_color_escape brblue
    set -g fish_color_autosuggestion brblack
    set -g fish_color_cwd cyan
    set -g fish_color_cwd_root red
    set -g fish_color_user green
    set -g fish_color_user_root red
    set -g fish_color_host blue
    set -g fish_color_host_remote blue
    set -g fish_color_status red
    set -g fish_color_cancel -r -o
    set -g fish_color_search_match brwhite -b brblack

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
end
