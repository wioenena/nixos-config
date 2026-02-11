{ pkgs, lib, ... }:
let
  flatpakApps = [
    # --- Networking & Download ---
    "org.qbittorrent.qBittorrent"

    # --- Graphics & Design ---
    "org.gimp.GIMP"
    "com.github.PintaProject.Pinta"
    "org.upscayl.Upscayl"
    "com.github.finefindus.eyedropper"
    "com.github.huluti.Curtail"
    "io.gitlab.adhami3310.Converter"
		"org.inkscape.Inkscape"
		"org.kde.krita"
		"com.github.libresprite.LibreSprite"
		"org.blender.Blender"

    # --- Audio Control & Effects ---
    "com.github.wwmm.easyeffects"

    # --- Desktop Environment Utilities ---
    "ca.desrt.dconf-editor"

    # --- Development & Technical Tools & Editors ---
    "me.iepure.devtoolbox"
    "net.werwolv.ImHex"
    "io.podman_desktop.PodmanDesktop"
    "com.getpostman.Postman"

    # --- Communication & Email ---
    "com.discordapp.Discord"
    "org.mozilla.Thunderbird"

    # --- Productivity & Office ---
    "md.obsidian.Obsidian"

    # --- Music ---
    "com.spotify.Client"

    # Browsers
    "app.zen_browser.zen"

    # --- Multimedia (Video/Audio Players & Editors) ---
    "no.mifi.losslesscut"
    "org.videolan.VLC"
    "io.mpv.Mpv"
    "org.shotcut.Shotcut"
    "fr.handbrake.ghb"
    "io.github.seadve.Kooha"
    "io.github.seadve.Mousai"

    # --- Security & Privacy ---
    "com.github.tchx84.Flatseal"
    "com.protonvpn.www"
    "me.proton.Pass"
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
