{
  description = "Home Manager configuration for Me QwQ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, flake-utils, nixpkgs, home-manager, neovim-nightly-overlay, ... }@inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # 'guo' is the username of the user whose home directory is being managed.
        homeConfigurations.guo = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = { inherit inputs; };
        };
      }
    );
}

