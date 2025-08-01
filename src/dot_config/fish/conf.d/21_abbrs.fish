if not status is-interactive
    return
end

function abbr_cargo
    abbr "C$argv[1]" cargo $argv[2..]
end

function abbr_docker
    abbr "D$argv[1]" docker $argv[2..]
end

function abbr_docker_compose
    abbr "Dc$argv[1]" docker-compose $argv[2..]
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
    abbr_cargo td test --doc
    abbr CC cargo_captured
end

if type -q cargo-nextest
    abbr_cargo t nextest run
end

if type -q docker
    abbr_docker
    abbr_docker c compose
    abbr_docker i image
    abbr_docker il image ls
    abbr_docker r run -it --rm

    abbr_docker c compose
    abbr_docker cl compose logs --tail=30 -f
    abbr_docker cr compose restart
end

if type -q git
    abbr_git
    abbr_git c clone
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

abbr Hdc history_delete -c
abbr Hdp history_delete -p
abbr FP exec fish -P

functions -e abbr_{command,docker,compose,git}
