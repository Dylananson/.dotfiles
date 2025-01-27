{
  description =  "My Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs, ...}: 
    let 
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ "/home/dtans/.dotfiles/nix/configuration.nix" ];
     };
    };
  };

}
