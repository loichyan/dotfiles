if status is-interactive
    function abbr_command
        ! type -q $argv[2] || abbr -a $argv[1] $argv[2..]
    end

    function abbr_cargo
        abbr_command C$argv[1] cargo $argv[2..]
    end

    function abbr_docker
        abbr_command D$argv[1] docker $argv[2..]
        abbr_command P$argv[1] podman $argv[2..]
    end

    function abbr_docker_compose
        abbr_command Dc$argv[1] docker-compose $argv[2..]
        abbr_command Pc$argv[1] podman-compose $argv[2..]
    end

    function abbr_git
        abbr_command G$argv[1] git $argv[2..]
    end

    abbr_cargo
    abbr_cargo t nextest
    abbr_cargo tr nextest run

    abbr_docker
    abbr_docker c compose
    abbr_docker i image
    abbr_docker il image ls
    abbr_docker r run -it --rm

    abbr_docker_compose
    abbr_docker_compose l logs --tail=30 -f
    abbr_docker_compose r restart

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

    functions -e abbr_{command,docker,compose,git}
end
