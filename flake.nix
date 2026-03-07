{
  description = "Statisaur development and CI flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        beamTools = with pkgs; [
          elixir
          erlang
          hex
          rebar3
          git
        ];
      in {
        devShells.default = pkgs.mkShell {
          packages = beamTools;
        };

        formatter = pkgs.nixpkgs-fmt;

        apps.ci = {
          type = "app";
          program = pkgs.writeShellScript "statisaur-ci" ''
            set -euo pipefail
            mix deps.get
            mix format --check-formatted
            mix test
          '';
        };
      });
}
