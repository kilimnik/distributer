{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs ({
          inherit system;
        });

      in
      {
        devShell = pkgs.pkgs.mkShell {

          buildInputs = with pkgs;
            [
              x11docker
            ];
        };

      });
}
