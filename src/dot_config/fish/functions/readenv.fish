# Credit to <https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc?permalink_comment_id=4747845#gistcomment-4747845>
function readenv -d "Read dotenv into current session"
    for envfile in $argv
        if not test -f "$envfile"
            echo "failed to load $envfile" >&2
            continue
        end
        string replace -r '^\w+=.+' 'export $0' <$envfile | source
        or echo "failed to load $envfile" >&2
    end
end
