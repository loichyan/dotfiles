function docker_vrestore
    [ -n "$argv" ] && argparse 'f/file=' 'v/volume=' -- $argv || return
    set -l file (realpath $_flag_f)
    set -l dir (dirname $path)
    set -l base (basename $path)
    set -l volume $_flag_v
    docker run --rm \
        -v "$dir:/tmp/backup:ro,Z" \
        -v "$volume:/tmp/volume" \
        alpine \
        sh -c "tar -C '/tmp/volume' -xvf '/tmp/backup/$base'"
end
