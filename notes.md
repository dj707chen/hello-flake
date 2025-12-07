# First Flake
Based on https://www.tweag.io/blog/2020-05-25-flakes/#writing-your-first-flake

```shell
echo 'int main() { printf("Hello World"); }' > hello.c

# To turn this Git repository into a flake, we add a file named flake.nix at the root of the repository with the following contents:
nix build

# Update in future
nix flake lock --update-input nixpkgs
nix flake update

# To wrap things up, we can now commit our project and push it to GitHub, after making sure that everything is in order:
nix flake check --all-systems

nix shell github:dj707chen/hello -c hello
```

So what does all that stuff in flake.nix mean?

- The description attribute is a one-line description shown by nix flake metadata.

- The inputs attribute specifies other flakes that this flake depends on. These are fetched by Nix and passed as arguments to the outputs function.

- The outputs attribute is the heart of the flake: it’s a function that produces an attribute set. The function arguments are the flakes specified in inputs.

- The self argument denotes this flake. Its primarily useful for referring to the source of the flake (as in src = self;) or to other outputs (e.g. self.defaultPackage.x86_64-linux).

- The attributes produced by outputs are arbitrary values, except that (as we saw above) there are some standard outputs such as defaultPackage.${system}.

- Every flake has some metadata, such as self.lastModifiedDate, which is used to generate a version string like hello-20191015.

