{ pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.wioenena = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$6$rCtRKK/unc.5Wp0S$.33avtuFOR0YErCosOtlduw1RvLrIMUeYQ4oOE/kJfyOGBJV7M7ljeSXG/.iKeFaCERwCh8L3sc9pom1sRGj21";
    description = "Barış Köprülü";
    createHome = true;
    shell = pkgs.fish;
  };
}
