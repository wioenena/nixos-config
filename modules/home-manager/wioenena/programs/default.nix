{ ... }:
{

  imports = [
    ./zen-browser.nix
  ];

  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
