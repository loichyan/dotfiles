function pip_save -d "Save Python dependencies"
    if test -z "$argv" || ! argparse o/output= -- $argv
        echo -n "\
USAGE:

pip_save -o <file>

OPTION:

-o/--output <file>  Output file (default is \"requirements.txt\")
"
        return 1
    end

    set -l out (test -n "$_flag_output" && echo $_flag_output || echo requirements.txt)
    set -l installed (pip freeze)

    for pname in $argv
        if set -l pversion (string match -ei $pname $installed)
            echo $pversion | tee -a "$out"
        else
            echo "Package $pname not found!" >&2
        end
    end
end
