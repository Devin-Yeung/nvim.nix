{ inputs, ... }:
{
  imports = [ ../config ];

  # Keep the config, Nixvim module, and its package set in one lock file.
  nixpkgs = {
    source = inputs.nixpkgs;
    overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
    config.allowUnfree = true;
  };
}
