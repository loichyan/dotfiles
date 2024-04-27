function bat-json -d "Show formatted JSON with highlight"
    jq $argv | bat -l json
end
