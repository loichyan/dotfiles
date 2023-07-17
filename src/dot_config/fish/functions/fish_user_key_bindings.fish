function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M insert \cb backward-kill-word
    bind -M insert \cf forward-word
    bind -M insert JK (bind -M insert \e | string match -r '\'(.*)\'$')[2]
end
