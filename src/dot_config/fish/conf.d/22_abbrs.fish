if status is-interactive
    function abbr_command
        ! type -q $argv[2] || abbr -a $argv[1] $argv[2..]
    end

    function abbr_docker
        abbr_command D$argv[1] docker $argv[2..]
        abbr_command P$argv[1] podman $argv[2..]
    end

    function abbr_compose
        abbr_command Dc$argv[1] docker-compose $argv[2..]
        abbr_command Pc$argv[1] podman-compose $argv[2..]
    end

    abbr_docker ''
    abbr_docker c compose
    abbr_docker i image ls
    abbr_docker r run -it --rm
    abbr_compose ''
    abbr_compose l logs --tail=30 -f

    abbr_command G git
    abbr_command Gf git fetch
    abbr_command Gl git log
    abbr_command Gp git push
    abbr_command Gs git status
    abbr_command Gck git checkout
    abbr_command Gsw git checkout

    functions -e abbr_{command,docker,compose}
end
