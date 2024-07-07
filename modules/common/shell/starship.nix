{
  config,
  pkgs,
  lib,
  ...
}:

{
  home-manager.users.${config.user}.programs.starship = {    
    # Starship Documentation
    # https://starship.rs/config/
    enable = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$hostname"
        "$directory"
        "$character"
      ];

      right_format = "$nix_shell";

      # Modules
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };

      hostname = {
        format = "on [$hostname](bold red) ";
      };

      directory = {
        truncate_to_repo = true;
        truncation_length = 10;
      };

      nix_shell = {
        format = "[$symbol $name]($style)";
        symbol = "❄️";
      };
    };
  };
}
