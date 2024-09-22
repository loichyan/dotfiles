function batjson -d "Show formatted JSON with highlight"
    jq $argv | bat -l json
end
