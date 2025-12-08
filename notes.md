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

nix shell github:dj707chen/hello-flake -c hello
# Hello World
```
