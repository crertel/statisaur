{
  description = "Statisaur development and CI flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        beamTools = with pkgs; [
          elixir
          erlang
          rebar3
          git
        ];
      in {
        devShells.default = pkgs.mkShell {
          packages = beamTools;
        };

        formatter = pkgs.nixpkgs-fmt;

        packages.ci = pkgs.writeShellApplication {
          name = "statisaur-ci";
          runtimeInputs = beamTools;
          text = ''
            set -euo pipefail
            mix local.hex --force
            mix deps.get
            mix format --check-formatted
            mix test
          '';
        };

        apps.ci = {
          type = "app";
          program = pkgs.lib.getExe self.packages.${system}.ci;
        };

        apps.default = self.apps.${system}.ci;
      });
}
