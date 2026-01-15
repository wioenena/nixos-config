{ pkgs, ... }:
let
  schemaPath = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gtk4}/share/gsettings-schemas/${pkgs.gtk4.name}"
    "${pkgs.yaru-theme}/share/gsettings-schemas/${pkgs.yaru-theme.name}"
  ];
in
{
  environment.systemPackages = with pkgs; [
    yaru-theme
    adwaita-icon-theme
    libadwaita
    apple-cursor
  ];

  environment.sessionVariables = {
    XDG_DATA_DIRS = schemaPath;
  };
}
