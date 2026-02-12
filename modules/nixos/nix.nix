{ pkgs, ... }:
{
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    settings.trusted-users = [
      "@wheel"
      "wioenena"
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;
    optimise.dates = [ "03:45" ];
    settings.auto-optimise-store = true;
  };

  systemd.services.nix-daemon.serviceConfig.LimitNOFILE = 65536;

  environment.systemPackages = [
    pkgs.nil
    pkgs.nixd
  ];
}
