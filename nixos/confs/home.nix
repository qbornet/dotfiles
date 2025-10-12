

{
  imports = [
    ./dotfiles.nix
  ];

  services.ssh-agent = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/github_ed25519";
        identitiesOnly = true;
      };
    };
  };

  home.username = "qbornet";
  home.homeDirectory = "/home/qbornet";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
