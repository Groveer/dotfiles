{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "guo";
  home.homeDirectory = "/home/guo";

  home.packages = with pkgs; [
    htop
    ripgrep
    nix-index
    nix-update
    python3
    nodejs
    git
    neovim
    lua
    starship
    vscode
    code-cursor
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

