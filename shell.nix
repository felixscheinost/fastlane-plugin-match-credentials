{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  gems = bundlerEnv {
    name = "fastlane-plugin-match_credentials-gems";
    inherit ruby;
    gemdir = ./nix/gem;
  };
in pkgs.mkShell { 
  buildInputs = [ gems cocoapods ruby bundix ]; 
}
