{
  description = "wioenena nixos setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      allowedUnfreePkgNames = import ./allowed-unfree-pkgs.nix;
      allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) allowedUnfreePkgNames;
      myOverlays = import ./overlays { };
      overlays = [
        myOverlays.gnomeExtensions
      ];
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        overlays = overlays;
        config.allowUnfreePredicate = allowUnfreePredicate;
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
        modules = [
          {
            nixpkgs.overlays = overlays;
            nixpkgs.config.allowUnfreePredicate = allowUnfreePredicate;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wioenena = ./modules/home-manager/wioenena/home.nix;

            home-manager.sharedModules = [ ];
            home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
          }
          ./hosts/desktop
          ./modules/nixos
        ];
      };
    }
    // inputs.flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
