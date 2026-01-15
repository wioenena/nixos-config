{
  inputs,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  portal-script = pkgs.writeShellScriptBin "wioenena-nixos-hyprland-portal" ''
    ${pkgs.coreutils}/bin/sleep 4
    ${pkgs.systemd}/bin/systemctl --user stop xdg-desktop-portal-hyprland
    ${pkgs.systemd}/bin/systemctl --user stop xdg-desktop-portal
    ${pkgs.systemd}/bin/systemctl --user start xdg-desktop-portal-hyprland
    ${pkgs.coreutils}/bin/sleep 4
    ${pkgs.systemd}/bin/systemctl --user start xdg-desktop-portal
  '';

  select-wallpaper =
    let
      matugenExe = inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default + "/bin/matugen";
      walkerExe = inputs.walker.packages.${system}.default + "/bin/walker";
      printfExe = pkgs.coreutils + "/bin/printf";
      notifySendExe = pkgs.libnotify + "/bin/notify-send";
    in
    pkgs.writeShellScriptBin "wioenena-nixos-select-wallpaper" ''
      WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

      shopt -s nullglob
      images=("$WALLPAPER_DIR"/*.{png,jpg,jpeg})

      if [ ''${#images[@]} -eq 0 ]; then
            ${notifySendExe} "No wallpaper found in: $WALLPAPER_DIR"
            exit 1
      fi

      selected=$(${printfExe} "%s\n" "''${images[@]}" | ${walkerExe} --dmenu)
      ${matugenExe} image "$selected"
    '';
in
{
  specialisation.Hyprland = {
    inheritParentConfig = true;
    configuration = {
      system.nixos.tags = [ "Hyprland" ];

      imports = [
        ./xdg.nix
        ./programs.nix
      ];

      # Disable GNOME
      services.desktopManager.gnome.enable = lib.mkForce false;

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        # withUWSM = true;
        package = pkgs-unstable.hyprland; # TODO: Replace with stable version when available
      };

      environment.systemPackages = [
        portal-script
        select-wallpaper
      ];

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
