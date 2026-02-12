{ pkgs, ... }:
{
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    corefonts
    font-awesome
    inter
    jetbrains-mono
    fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
  ];
}
