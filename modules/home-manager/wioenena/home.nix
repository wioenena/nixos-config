{
  pkgs,
  ...
}:

{
  imports = [
    ./default.nix
  ];

  home.username = "wioenena";
  home.homeDirectory = "/home/wioenena";

  home.stateVersion = "25.11";

  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    name = "macOS";
    size = 24;
    package = pkgs.apple-cursor;
  }; # TODO: move to a separate module

  programs.home-manager.enable = true;
}
