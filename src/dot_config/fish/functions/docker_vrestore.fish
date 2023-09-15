function docker_vrestore -d "Restore a docker volume"
    if [ -z "$argv" ] || ! argparse f/file= v/volume= -- $argv
        echo -n "\
Usage:

-f/--file:   Output file (gzip compressed tarball)
-v/--volume: Volume to restore
"
        return
    end
    set -l file (realpath $_flag_file)
    set -l dir (dirname $file)
    set -l base (basename $file)
    set -l volume $_flag_volume
    docker run --rm \
        -v $volume:/tmp/volume \
        -v $dir:/tmp/backup:ro,Z \
        alpine \
        sh -c "tar -C '/tmp/volume' -xvzf '/tmp/backup/$base'"
end
