function docker_vbackup
    test -n "$argv" && argparse f/file= v/volume= -- $argv || return
    set -l file (realpath $_flag_f)
    set -l dir (dirname $file)
    set -l base (basename $file)
    set -l volume $_flag_v
    docker run --rm \
        -v $volume:/tmp/volume:ro,Z \
        -v $dir:/tmp/backup:Z \
        alpine \
        sh -c "tar -C '/tmp/volume' -cvzf '/tmp/backup/$base' ."
end
