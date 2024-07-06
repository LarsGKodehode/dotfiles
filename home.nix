{
  pkgs,
  config,
  username,
  ...
}:

{
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    # Utilities
    jq
    htmlq
    yq-go
    ripgrep
    tree
  ];

  programs.git = {
    enable = true;
    userName = "zabronax";
    userEmail = "zabronax@gmail.com";
  };

  #programs.starship = {
  #  enable = true;
  #};
}
