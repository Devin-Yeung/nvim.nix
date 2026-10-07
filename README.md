# nvim.nix

A batteries-included [Nixvim](https://github.com/nix-community/nixvim) configuration.

The flake locks the configuration together with its Nixvim, Nixpkgs, and Neovim-nightly-overlay revisions.
Consumers should import the exported module rather than separately pinning Nixvim.

## Home Manager

Add this repository as a flake input, without overriding its inputs:

```nix
{
  inputs.nvim-config.url = "github:Devin-Yeung/nvim.nix";
}
```

Import the module in a Home Manager configuration:

```nix
{
  imports = [ inputs.nvim-config.homeModules.default ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
```

## Standalone build

Build the locked configuration directly:

```sh
nix build
```
