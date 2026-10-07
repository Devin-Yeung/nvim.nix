# nvim.nix

A batteries-included [Nixvim](https://github.com/nix-community/nixvim) module

## Use

Add this repository and Nixvim as flake inputs (pin the revision in `flake.lock`):

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-config = {
      url = "github:Devin-Yeung/nvim.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixvim, nvim-config, ... }:
    let
      system = "x86_64-linux"; # or builtins.currentSystem
    in {
      packages.${system}.default = nixvim.legacyPackages.${system}.makeNixvim {
        imports = [ "${nvim-config}/config" ];
        nixpkgs.config.allowUnfree = true;
      };
    };
}
```
