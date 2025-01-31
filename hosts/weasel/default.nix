# System configuration for WSL

{
  inputs,
  globals,
  overlays,
  ...
}:

let
  system = "x86_64-linux";
in
inputs.nixpkgs.lib.nixosSystem
  {
  inherit system;
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/nixos
    ../../modules/wsl
    globals
    inputs.wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
    inputs.vscode-server.nixosModules.default
    {
      networking.hostName = "weasel";
      nixpkgs.overlays = overlays;
      theme = {
        colors = (import ../../colorscheme/nord).dark;
        dark = false;
      };

      # Enable the VS Code Server for remote work
      # TODO Figure out how to move all of this into it's
      # own module
      programs.nix-ld = {
        enable = true;
        package = inputs.nix-ld-rs.packages."${system}".nix-ld-rs;
      };
      services.vscode-server.enable = true;

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
    }
  ];
}
