{
  description = "A flake for building Hello World";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
  let
    mkHello = system:
      (with import nixpkgs { inherit system; };
        stdenv.mkDerivation {
          name = "hello";
          src = ./.;
          nativeBuildInputs = [ gcc ];
          buildPhase = "gcc -o hello ./hello.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
        }
      );
  in {
    packages.x86_64-linux.default   = mkHello "x86_64-linux";
    packages.aarch64-darwin.default = mkHello "aarch64-darwin";
    defaultPackage.x86_64-linux     = mkHello "x86_64-linux";
    defaultPackage.aarch64-darwin   = mkHello "aarch64-darwin";
  };
}
