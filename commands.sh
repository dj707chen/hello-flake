
# https://www.tweag.io/blog/2020-05-25-flakes/#writing-your-first-flake

echo 'int main() { printf("Hello World"); }' > hello.c

# To turn this Git repository into a flake, we add a file named flake.nix at the root of the repository with the following contents:

nix build
