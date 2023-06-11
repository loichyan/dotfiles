function docker_vbackup
    [ -n "$argv" ] && argparse 'f/file=' 'v/volume=' -- $argv || return
    set -l file (realpath $_flag_f)
    set -l dir (dirname $path)
    set -l base (basename $path)
    set -l volume $_flag_v
    docker run --rm \
        -v "$dir:/tmp/volume:ro" \
        -v "$volume:/tmp/backup:Z" \
        alpine \
        sh -c "tar -C '/tmp/volume' -cvf '/tmp/backup/$base' ."
end
