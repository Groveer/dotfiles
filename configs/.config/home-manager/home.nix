{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "guo";
  home.homeDirectory = "/home/guo";

  home.packages = with pkgs; [
    neofetch
    htop
    ripgrep
    cargo
    lemonade
    nix-index
    nix-update

    nodejs

    neovim
    lua
    starship
  ];

  # neovim nightly

  # nixpkgs.overlays = [
  #   inputs.neovim-nightly-overlay.overlays.default
  # ];

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

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

