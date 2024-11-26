{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gcc            # GNU Compiler Collection
    pkgs.gnumake           # For building projects using Makefiles
    pkgs.gdb            # GNU Debugger
    pkgs.valgrind       # Memory debugging and profiling tool
  ];

  shellHook = ''
    echo "Environment ready for C Development."
    echo "Available tools: gcc, make, gdb, valgrind"
  '';
}
