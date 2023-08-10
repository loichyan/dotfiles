function pip_save -d "Save Python dependencies"
    if [ -z "$argv" ] || ! argparse o/output= -- $argv
        return
    end
    set -l out (if [ -n "$_flag_output" ]; echo $_flag_output; else; echo requirements.txt; end)
    set -l installed (pip freeze)
    for pname in $argv
        if set -l pversion (string match -ei $pname $installed)
            echo $pversion | tee -a "$out"
        else
            echo "Package $pname not found!" >&2
        end
    end
end
