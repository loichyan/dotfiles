function cargo_doc_server -d "Start a server for Cargo documentation"
    if test -z "$argv" || ! argparse nightly cfg-docsrs p/port= -- $argv
        echo -n "\
Usage:

  cargo_doc_server [OPTIONS]

Options:

  -p/--port <int>  Port to listen on
  --nightly        Use nightly Rust toolchain
  --cfg-docsrs     Set `--cfg=docsrs` flag
"
        return 1
    end

    set -l port $_flag_port
    set -l cargo_watch (set -q _flag_nightly && echo "cargo-nightly-watch" || echo "cargo-watch")
    set -l rustflags

    if set -q _flag_cfg_docsrs
        set -a rustflags --cfg docsrs
    end


    fish -c "
    $cargo_watch -E RUSTFLAGS='$rustflags' -x 'doc $argv' &
    mkdir -p target
    dufs -p $port[1] --allow-search --enable-cors --render-spa --render-try-index target
    "
end
