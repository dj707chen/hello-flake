/*
So what does all that stuff in flake.nix mean?
- The description attribute is a one-line description shown by nix flake metadata.
- The inputs attribute specifies other flakes that this flake depends on. These are fetched by Nix and passed as arguments to the outputs function.
- The outputs attribute is the heart of the flake: it’s a function that produces an attribute set.
  The function arguments are the flakes specified in inputs.
- The self argument denotes this flake. Its primarily useful for referring to the source of the flake (as in src = self;) or to other outputs (e.g. self.defaultPackage.x86_64-linux).
- The attributes produced by outputs are arbitrary values, except that (as we saw above) there are some standard outputs such as packages.${system}.default.
- Every flake has some metadata, such as self.lastModifiedDate, which is used to generate a version string like hello-20191015.
*/
{
  description = "A flake for building Hello World";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
  let
    mkHello = system:
      (with import nixpkgs { inherit system; };
        stdenv.mkDerivation {
          name = "hello-flake";
          src = ./.;
          nativeBuildInputs = [ gcc ];
          buildPhase = "gcc -o hello ./hello.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
        }
      );
  in {
    packages.aarch64-darwin.default = mkHello "aarch64-darwin";
    packages.x86_64-linux.default   = mkHello "x86_64-linux";
  };
}
