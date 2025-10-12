{
  description = "NixOS systems and tools";
  inputs = {
    # Main nixpkgs repo
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Repo for google-chrome
    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ghostty repo
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    # My dotfiles
    dotfiles = {
      url = "github:qbornet/dotfiles";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    chrome = inputs.browser-previews.packages.${system}.google-chrome;
  in {
      # Overlays to expose new pkgs added.
      overlays = {
        default = final: prev: {
          google-chrome-stable = chrome;
          ghostty = inputs.ghostty.packages.${system}.default;
        };
      };

      # NixOS configuration required to run properly
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          dotfiles = inputs.dotfiles;
        };
        modules = [
          {
            nixpkgs.overlays = [
              self.overlays.default
            ];
          }

          ./configuration.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.qbornet = import ./confs/home.nix;
            home-manager.extraSpecialArgs = {
              dotfiles = inputs.dotfiles;
              inputs = inputs;
            };
          }
        ];
      };
    };
}
