function cargo_captured -w cargo -d "Capture output of a cargo command"
    cargo $argv -- --nocapture 2>&1
end
