#!/usr/bin/env bash

# {
#   bg0 = "#131a24",
#   bg1 = "#192330",
#   bg2 = "#212e3f",
#   bg3 = "#29394f",
#   bg4 = "#39506d",
#   black = {
#     base = "#393b44",
#     bright = "#575860",
#     dim = "#30323a",
#     light = false,
#     <metatable> = <1>{
#       __call = <function 1>,
#       __index = <table 1>,
#       harsh = <function 2>,
#       new = <function 3>,
#       subtle = <function 4>
#     }
#   },
#   blue = {
#     base = "#719cd6",
#     bright = "#86abdc",
#     dim = "#6085b6",
#     light = false,
#     <metatable> = <table 1>
#   },
#   comment = "#738091",
#   cyan = {
#     base = "#63cdcf",
#     bright = "#7ad4d6",
#     dim = "#54aeb0",
#     light = false,
#     <metatable> = <table 1>
#   },
#   fg0 = "#d6d6d7",
#   fg1 = "#cdcecf",
#   fg2 = "#aeafb0",
#   fg3 = "#71839b",
#   generate_spec = <function 5>,
#   green = {
#     base = "#81b29a",
#     bright = "#8ebaa4",
#     dim = "#6e9783",
#     light = false,
#     <metatable> = <table 1>
#   },
#   magenta = {
#     base = "#9d79d6",
#     bright = "#baa1e2",
#     dim = "#8567b6",
#     light = false,
#     <metatable> = <table 1>
#   },
#   meta = {
#     light = false,
#     name = "nightfox"
#   },
#   orange = {
#     base = "#f4a261",
#     bright = "#f6b079",
#     dim = "#cf8a52",
#     light = false,
#     <metatable> = <table 1>
#   },
#   pink = {
#     base = "#d67ad2",
#     bright = "#dc8ed9",
#     dim = "#b668b2",
#     light = false,
#     <metatable> = <table 1>
#   },
#   red = {
#     base = "#c94f6d",
#     bright = "#d16983",
#     dim = "#ab435d",
#     light = false,
#     <metatable> = <table 1>
#   },
#   sel0 = "#2b3b51",
#   sel1 = "#3c5372",
#   white = {
#     base = "#dfdfe0",
#     bright = "#e4e4e5",
#     dim = "#bebebe",
#     light = false,
#     <metatable> = <table 1>
#   },
#   yellow = {
#     base = "#dbc074",
#     bright = "#e0c989",
#     dim = "#baa363",
#     light = false,
#     <metatable> = <table 1>
#   }


# Nightfox colors for Tmux
# Upstream: github:edeneast/nightfox.nvim/main/extra/nightfox/nightfox_tmux.tmux
black="#131a24"
white="#aeafb0"
blue="#719cd6"
yellow="#dbc074"
grey="#393b44"
seg_a="$blue $black"
seg_b="$grey $white"
seg_c="$black $white"

# Misc styles.
set -g mode-style "fg=$black,bg=$yellow"
set -g message-style "fg=$black,bg=$yellow"
set -g message-command-style "fg=$black,bg=$yellow"

# Single row.
set -g @nova-rows 0

# Enable nerdfonts.
set -g @nova-nerdfonts true

# Status bar style.
set -g @nova-status-style-bg "$black"
set -g @nova-status-style-fg "$white"
set -g @nova-status-style-double-bg "$black"

# Pane style.
set -g @nova-pane "#S:#W"
set -g @nova-status-style-active-bg "$black"
set -g @nova-status-style-active-fg "$white"
set -g @nova-pane-border-style "$black"
set -g @nova-pane-active-border-style "$blue"

# Mode segment.
set -g @nova-segment-mode "#[bold]#{?client_prefix,C-B,NOP}"
set -g @nova-segment-mode-colors "$seg_a"

# Whoami segment.
set -g @nova-segment-whoami "#[bold]#(whoami)@#h"
set -g @nova-segment-whoami-colors "$seg_a"

# Date segment.
set -g @nova-segment-date "%Y/%m/%d"
set -g @nova-segment-date-colors "$seg_b"

# Time segment.
set -g @nova-segment-time "%R"
set -g @nova-segment-time-colors "$seg_c"

# Left segments.
set -g @nova-nerdfonts-left ""
set -g @nova-segments-0-left "mode"

# Right segments.
set -g @nova-nerdfonts-right ""
set -g @nova-segments-0-right "time date whoami"
