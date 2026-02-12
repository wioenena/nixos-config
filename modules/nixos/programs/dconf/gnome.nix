{ pkgs, lib, ... }:
{
  programs.dconf.profiles.user.databases = [
    {
      lockAll = false;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          accent-color = "orange";
          font-name = "Inter Medium 11";
          document-font-name = "Inter Medium 12";
          monospace-font-name = "JetBrains Mono Medium 11";
          font-antialiasing = "rgba";
          cursor-theme = "macOS";
          icon-theme = "Yaru";
          gtk-theme = "Yaru-dark";
        };
        "org/gnome/desktop/sound" = {
          theme-name = "Yaru";
        };
        "org/gnome/mutter" = {
          experimental-features = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        };
        "org/gnome/shell" = {
          favorite-apps = [
            "org.gnome.Settings.desktop"
            "org.gnome.Nautilus.desktop"
            "org.gnome.Software.desktop"
            "app.zen_browser.zen.desktop"
            "org.gnome.Ptyxis.desktop"
            "dev.zed.Zed.desktop"
            "code.desktop"
          ];
          enabled-extensions = with pkgs.gnomeExtensions; [
            applications-menu.extensionUuid
            places-status-indicator.extensionUuid
            dash-to-dock.extensionUuid
            gsconnect.extensionUuid
            caffeine.extensionUuid
            desktop-icons-ng-ding.extensionUuid
            add-to-desktop.extensionUuid
            show-desktop-applet.extensionUuid
            appindicator.extensionUuid
            blur-my-shell.extensionUuid
          ];
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-windows = [ "<Alt>Tab" ];
          switch-windows-backward = [ "<Shift><Alt>Tab" ];
        };
        "org/gnome/settings-daemon/plugins/power" = {
          power-button-action = "interactive";
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
        "org/gnome/system/location" = {
          enabled = true;
        };
        "org/gnome/GWeather4" = {
          temperature-unit = "centigrade";
        };

        "org/gnome/nautilus/preferences" = {
          show-create-link = true;
          show-delete-permanently = true;
        };
        "org/gnome/Ptyxis" = {
          audible-bell = false;
          restore-window-size = false;
          default-columns = lib.gvariant.mkUint32 80;
          default-rows = lib.gvariant.mkUint32 24;
        };
        # Extensions
        "org/gnome/shell/extensions/dash-to-dock" = {
          dash-max-icon-size = lib.gvariant.mkInt32 40;
          custom-theme-shrink = true;
          click-action = "minimize";
          show-apps-at-top = true;
          custom-background-color = true;
          background-color = "rgb(0, 0, 0)";
          transparency-mode = "FIXED";
          background-opacity = lib.gvariant.mkDouble 0.85;
        };
        "org/gnome/shell/extensions/gsconnect" = {
          enabled = false;
        };
        "org/gnome/shell/extensions/ding" = {
          icon-size = "tiny";
        };
      };
    }
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/input-sources" = {
          xkb-options = [ "caps:none" ];
          sources = [
            (lib.gvariant.mkTuple [
              "xkb"
              "us"
            ])
            (lib.gvariant.mkTuple [
              "xkb"
              "tr"
            ])
          ];
        };
      };
    }
  ];
}
