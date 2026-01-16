{ pkgs, lib, ... }:
let
  flatpakApps = [
    # --- Music ---
    "com.spotify.Client"

    # Browsers
    "app.zen_browser.zen"

    # --- Multimedia (Video/Audio Players & Editors) ---
    "no.mifi.losslesscut"

    # --- Security & Privacy ---
    "com.github.tchx84.Flatseal"
  ];

  appsString = lib.strings.concatStringsSep " " flatpakApps;
  flatpakExe = lib.getExe pkgs.flatpak;
  flatpakInstallAppsScript = pkgs.writeShellScriptBin "wioenena-install-flatpak-apps" ''
    echo "--------------------------------------------------"
    echo "Running Flatpak installation script..."
    echo "--------------------------------------------------"
    ${flatpakExe} remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    ${flatpakExe} install -y --noninteractive flathub ${appsString}
    ${flatpakExe} uninstall --unused
    ${flatpakExe} --user override --filesystem=/nix/store:ro # For fix theming problems
    echo "--------------------------------------------------"
    echo "Operation completed successfully!"
    echo "--------------------------------------------------"
  '';
in
{
  services.flatpak.enable = true;
  environment.systemPackages = [ flatpakInstallAppsScript ];
}
