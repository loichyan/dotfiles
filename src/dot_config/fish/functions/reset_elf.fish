function reset_elf -d "Clear /nix/* interpreter and RPATHs"
    if test -z "$argv" || ! argparse -N1 -X1 p/rpath -- $argv
        echo -n "\
USAGE:

reset_elf [OPTION]... <exeutable>

OPTION:

-p/--rpath  Remove all hardcoded RPATHs
"
        return 1
    end

    if test -z "$argv" || ! argparse prefix=+ -- $argv
        echo -n "\
Usage:

--prefix: Search histories by prefix
"
        return 1
    end

    patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 $argv
    and patchelf --remove-rpath $argv
end
