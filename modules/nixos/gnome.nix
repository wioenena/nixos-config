{ pkgs, lib, ... }:
let
  gnomeExtensions = with pkgs.gnomeExtensions; [
    applications-menu
    places-status-indicator
    dash-to-dock
    gsconnect
    caffeine
    desktop-icons-ng-ding
    add-to-desktop
    show-desktop-applet
    appindicator
    blur-my-shell
  ];
in
{
  services.desktopManager.gnome.enable = true;
  services.gnome = {
    gnome-user-share.enable = false;
    rygel.enable = false;
    gnome-online-accounts.enable = false;
    tinysparql.enable = true; # For nautilus
    localsearch.enable = true; # For nautilus
    core-apps.enable = true;
    gnome-settings-daemon.enable = true;
  };

  environment.systemPackages = gnomeExtensions;

  # Excluded packages
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-contacts
    gnome-music
    gnome-console
    decibels
    epiphany
    papers
    simple-scan
    snapshot
    geary
    yelp
  ];

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };
}
