function git_sync_mirror -d "Sync mirror repo"
    if test -z "$argv" || ! argparse s/src= d/dest= -- $argv
        echo -n "\
Usage:

  git_sync_mirror [OPTIONS]

Options:

  -s/--src <repo>   Source repository
  -d/--dest <repo>  Destination repository
"
        return
    end

    set -l src $_flag_src
    set -l dest $_flag_dest
    if test -z "$src" || test -z "$dest"
        echo "'--src/--dest' must be specified"
        return 1
    end

    set -l CWD (pwd)
    set -l workdir (mktemp -d)
    cd $workdir

    git clone --mirror $src .
    # Delete PRs
    git for-each-ref --format="delete %(refname)" refs/pull | git update-ref --stdin
    git push --mirror $dest

    cd $CWD
    rm -rf $workdir
end

git_sync_mirror $argv
