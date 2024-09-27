# https://nix.dev/tutorials/declarative-and-reproducible-developer-environments
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  
  # Package names can be found via https://search.nixos.org/packages
  nativeBuildInputs = [
    pkgs.rustup
  ];

  # Optionally, you can specify a particular version of Rust
  # You can uncomment and set the desired version if needed
  # RUST_VERSION = "1.70.0";

  # Environment variables
  shellHook = ''
    echo 'Rust development environment ready!'
  '';
}

