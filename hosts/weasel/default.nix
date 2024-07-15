# System configuration for WSL

{
  inputs,
  globals,
  overlays,
  ...
}:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/nixos
    ../../modules/wsl
    globals
    inputs.wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
    {
      networking.hostName = "weasel";
      nixpkgs.overlays = overlays;
      theme = {
        #colors = (import ../../colorscheme/gruvbox-light-soft).light;
        colors = (import ../../colorscheme/nord).dark;
        dark = false;
      };

      # Enable Nix experimental feauters for this host
      nix.settings.experimental-features = "nix-command flakes";

      wsl = {
        enable = true;
        wslConf.automount.root = "/mnt";
        defaultUser = globals.user;
        startMenuLaunchers = true;
        nativeSystemd = true;
        wslConf.network.generateResolvConf = true; # Turn of if it breaks VPN
        interop.includePath = false; # Including Windows PATH will slow down other systems, filesystem cross talk
      };

      vscode.enable = true;
    }
  ];
}
