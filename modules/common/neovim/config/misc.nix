{
  pkgs,
  dsl,
  lib,
  ...
}:

{
  vim.o = {
    termguicolors = true; # Set to true color
    hidden = true; # Don't offload buffers when leaving them
    list = true; # Reveal whitespaces with dashes
    expandtab = true; # Turn tabs into spaces
    softtabstop = 2; # Amount to shift with <TAB> key
    incsearch = true; # Search while typing
    visualbell = true; # No sounds
    mouse = "nv"; # Mouse interaction / scrolling
  };

  vim.wo = {
    number = true; # Show line numbers
    relativenumber = true; # Realative instead of absolute numbers
  };
}
