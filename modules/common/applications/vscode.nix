{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    vscode = {
      enable = lib.mkEnableOption {
        description = "Enable Visual Studio Code";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.vscode.enable) {
    unfreePackages = [
      "vscode"
    ];

    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ vscode ];
    };
  };
}
