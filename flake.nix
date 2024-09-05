{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      self,
    }:
    let
      allSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      # A function that provides a system-specific Nixpkgs for the desired systems
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            inherit system;
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      packages = forAllSystems (
        {
          pkgs,
          system,...
        }:
        rec {
          default = pkgs.callPackage ./nix {};
        }
      );
    };
}
