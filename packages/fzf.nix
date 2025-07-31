{ fzf, symlinkJoin }:
symlinkJoin {
  name = "fzf";
  paths = [ fzf ];
  postBuild = ''
    # Remove auto-load for fzf keybindings
    rm -r $out/share/fish/vendor_conf.d
  '';
}
