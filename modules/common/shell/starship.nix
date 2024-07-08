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
      palette = "nord";

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

      right_format = "$nix_shell";

      # Modules
      character = {
        format = " $symbol ";
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };

      hostname = {
        format = "on [$hostname](bold red)";
      };

      directory = {
        truncate_to_repo = true;
        truncation_length = 10;
      };

      kubernetes = {
        format = " [󱃾 $context\($namespace\)](bold purple)";
        disabled = false;
      };

      nix_shell = {
        format = "[$symbol $name]($style)";
        symbol = "❄️";
      };

      git_branch = {
        format = "[$symbol$branch]($style)";
        symbol = "";
        truncation_symbol = ".../";
        style = "bold green";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "⋄";
        stashed = "⩮";
        modified = "∽";
        staged = "+";
        renamed = "»";
        deleted = "✘";
        style = "red";
      };

      # Theming
      palettes.nord = {
        black = "#1d2021";
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
