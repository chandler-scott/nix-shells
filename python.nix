let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.poetry
  ];

  shellHook = ''
    poetry install
    echo "Environment ready for Python Development."
  '';
}

