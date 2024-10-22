function docker_vbackup -d "Backup a docker volume"
    if test -z "$argv" || ! argparse f/file= v/volume= -- $argv
        echo -n "\
Usage:

  docker_vbackup [OPTIONS]

Options:

  -f/--file <file>      Output file (gzip compressed tarball)
  -v/--volume <volume>  Volume to backup
"
        return 1
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
