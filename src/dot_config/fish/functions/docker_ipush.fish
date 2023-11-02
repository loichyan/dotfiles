function docker_ipush -d "Push an image to a SSH server"
    if test -z "$argv" || ! argparse i/image= d/dest= -- $argv
        echo -n "\
Usage:

-i/--image: Image to be pushed
-d/--dest : Destination SSH server
"
        return 1
    end
    docker save $_flag_image | ssh -C $_flag_dest "docker load"
end
