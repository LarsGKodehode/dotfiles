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
      # Configurations
      command_timeout = 1000;
      palette = "outsourced";

      # Looks
      add_newline = false;
      format = lib.concatStrings [
        "$hostname"
        "$nix_shell"
        "$kubernetes"
        "$directory"
        "$git_branch"
        "$git_status"
        "$character"
      ];

      # Modules
      character = {
        format = "$symbol ";
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

      kubernetes = {
        format = " [󱃾 $context\($namespace\)](bold purple) ";
        disabled = false;
      };

      nix_shell = {
        format = "[$state]($style) ";
        impure_msg = "[❅](bold red)";
      };

      git_branch = {
        format = "[$symbol$branch]($style)";
        symbol = "";
        truncation_symbol = ".../";
        style = "bold green";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style)) ";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        modified = "!";
        staged = "+";
        style = "bold red";
      };

      # Theming
      palettes.outsourced = {
        black = config.theme.colors.base00;
        red = config.theme.colors.base08;
        green = config.theme.colors.base0B;
        yellow = config.theme.colors.base0A;
        blue = config.theme.colors.base0D;
        magenta = config.theme.colors.base0E;
        cyan = config.theme.colors.base0C;
        white = config.theme.colors.base05;
      };
    };
  };
}
