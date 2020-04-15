let
  hostPkgs = import <nixpkgs> {};
  # nixos-20.03 on 12.04.2020
  pinnedVersion = hostPkgs.lib.importJSON ./nixpkgs.json;
  pinnedPkgs = import (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    inherit (pinnedVersion) rev sha256;
  }) {};
in
with pinnedPkgs;
let
  gems = bundlerEnv {
    name = "fastlane-plugin-match_credentials-gems";
    inherit ruby;
    gemdir = ./nix/gem;
  };
in pinnedPkgs.mkShell { 
  buildInputs = [ gems cocoapods ruby bundix ]; 
}
