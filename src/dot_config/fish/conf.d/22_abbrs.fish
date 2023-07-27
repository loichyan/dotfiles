if status is-interactive
    function abbr_cargo
        abbr "C$argv[1]" cargo $argv[2..]
    end

    function abbr_docker
        abbr "$D$argv[1]" $docker $argv[2..]
    end

    function abbr_docker_compose
        abbr "$D"c"$argv[1]" "$docker"-compose $argv[2..]
    end

    function abbr_git
        abbr "G$argv[1]" git $argv[2..]
    end

    if type -q cargo
        abbr_cargo
        abbr_cargo a add
        abbr_cargo ab add --build
        abbr_cargo ad add --dev
        abbr_cargo b build
        abbr_cargo br build --release
        abbr_cargo c clippy
        abbr_cargo r run
        abbr_cargo rr run --release
        abbr_cargo t test
    end

    set -l cmds
    if type -q docker
        set -a cmds docker,D
    end
    if type -q podman
        set -a cmds podman,P
    end
    for cmd in $cmds
        echo $cmd | read -d , docker D
        docker=$docker D=$D begin
            if type -q "$docker"-compose
                alias "$docker"-compose "$docker compose"
            end
            abbr_docker
            abbr_docker c compose
            abbr_docker i image
            abbr_docker il image ls
            abbr_docker r run -it --rm
            abbr_docker_compose
            abbr_docker_compose l logs --tail=30 -f
            abbr_docker_compose r restart
        end
    end

    if type -q git
        abbr_git
        abbr_git c commit
        abbr_git f fetch
        abbr_git l log
        abbr_git m merge
        abbr_git mc merge --continue
        abbr_git p push
        abbr_git r rebase
        abbr_git rc rebase --continue
        abbr_git s status
        abbr_git ck checkout
        abbr_git sw checkout
    end

    functions -e abbr_{command,docker,compose,git}
end
