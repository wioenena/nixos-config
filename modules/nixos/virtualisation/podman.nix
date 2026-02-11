{ pkgs, lib, ... }:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  systemd.sockets.podman.wantedBy = lib.mkForce [ ];

  environment.systemPackages = with pkgs; [
    podman-desktop
    podman-compose
    kubectl
    kind
  ];

  users.users.wioenena.extraGroups = [ "podman" ];
}
