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
    globals # TODO: Why is this here?
    inputs.wsl.nixosModules.wsl # TODO: What's this?
    inputs.home-manager.nixosModules.home-manager # TODO: What's this?
    {
      networking.hostName = "weasel";
      nixpkgs.overlays = overlays;

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
