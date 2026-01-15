{ pkgs, lib, ... }:
let
  flatpakApps = [
    "com.spotify.Client"
    "no.mifi.losslesscut"

    # --- Security & Privacy ---
    "com.github.tchx84.Flatseal"
  ];

  appsString = lib.strings.concatStringsSep " " flatpakApps;
  flatpakExe = lib.getExe pkgs.flatpak;
  flatpakInstallAppsScript = pkgs.writeShellScriptBin "install-flatpak-apps" ''
    echo "--------------------------------------------------"
    echo "Running Flatpak installation script..."
    echo "--------------------------------------------------"
    ${flatpakExe} remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    ${flatpakExe} install -y --noninteractive flathub ${appsString}
    ${flatpakExe} uninstall --unused
    echo "--------------------------------------------------"
    echo "Operation completed successfully!"
    echo "--------------------------------------------------"
  '';
in
{
  services.flatpak.enable = true;
  environment.systemPackages = [ flatpakInstallAppsScript ];
}
