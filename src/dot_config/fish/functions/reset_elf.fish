function reset_elf -d "Clear /nix/* interpreter and RPATHs"
    patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 $argv
    patchelf --remove-rpath $argv
end
