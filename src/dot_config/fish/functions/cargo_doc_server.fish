function cargo_doc_server -d "Start a server for Cargo documentation"
    if test -z "$argv" || ! argparse "p/port=" -- $argv
        echo -n "\
USAGE:

cargo_doc_server -p <int>

OPTION:

-p/--port <int>  Port to listen on
"
        return 1
    end

    set -l port $_flag_port
    fish -c "
    cargo-nightly-watch -E RUSTFLAGS='--cfg docsrs' -x 'doc $argv' &
    dufs -p $port[1] --allow-search --enable-cors --render-spa --render-try-index target
    "
end
