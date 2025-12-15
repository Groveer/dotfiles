{ inputs, config, pkgs, lib, ... }:

let
  currentUser = builtins.getEnv "USER";
  currentHome = builtins.getEnv "HOME";
in
{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home = {
    username =
      if currentUser != ""
      then lib.mkForce currentUser
      else throw "$USER not set";

    homeDirectory =
      if currentHome != ""
      then lib.mkForce currentHome
      else throw "$HOME not set";
  };

  home.packages = with pkgs; [
    htop
    ripgrep
    nix-index
    python3
    nodejs
    git
    neovim
    tree-sitter
    lua
    starship
    wl-clipboard
    bat
    eza
    jq
  ];

nixpkgs.overlays = [
  inputs.neovim-nightly-overlay.overlays.default
];

  fonts.fontconfig.enable = true; # Allow fontconfig to discover fonts in home.packages

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  services.gpg-agent = {
    enable = false;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  home.shellAliases = {
    "..." = "cd ../..";
  };

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}

