# Credit to <https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc?permalink_comment_id=4747845#gistcomment-4747845>
function readenv -d "Read dotenv into current session"
    for envfile in $argv
        if not test -f "$envfile"
            echo "failed to load $envfile" >&2
            return 1
        end

        while read line
            if set kv (string match -gr '^(\w+)=(.+)' $line)
                set kv[2] (eval echo $kv[2]) # expand any variables in the value
                set -gx $kv
            end
        end <$envfile
    end
end
