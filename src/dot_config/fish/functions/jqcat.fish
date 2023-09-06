function jqcat -d "Show formatted JSON with hightlight"
    jq '' $argv | bat -l json
end
