function docker_vbackup -d "Backup a docker volume"
    if [ -z "$argv" ] || ! argparse f/file= v/volume= -- $argv
        echo -n "\
Usage:

-f/--file:   Output file (gzip compressed tarball)
-v/--volume: Volume to backup
"
        return
    end
    set -l file (realpath $_flag_file)
    set -l dir (dirname $file)
    set -l base (basename $file)
    set -l volume $_flag_volume
    docker run --rm \
        -v $volume:/tmp/volume:ro \
        -v $dir:/tmp/backup:Z \
        alpine \
        sh -c "tar -C '/tmp/volume' -cvzf '/tmp/backup/$base' ."
end
