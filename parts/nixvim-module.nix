{ inputs, ... }:
{
  flake.nixvimModules.default = {
    imports = [ ../config ];

    nixpkgs = {
      source = inputs.nixpkgs;
      overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
      config.allowUnfree = true;
    };
  };
}
