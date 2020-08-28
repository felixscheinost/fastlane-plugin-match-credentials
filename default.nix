let
  sources = import nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
  pkgs.bundlerEnv {
    name = "fastlane-plugin-match_credentials-gems";
    ruby = pkgs.ruby;
    gemdir = ./nix/gem;
  }