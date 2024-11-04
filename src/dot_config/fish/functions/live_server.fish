function live_server -d "Start a file server of a local directory"
    dufs --allow-search --enable-cors --render-spa --render-try-index $argv
end
