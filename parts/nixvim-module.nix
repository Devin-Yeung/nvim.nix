{ inputs, ... }:
{
  flake.nixvimModules.default = {
    imports = [ ../config ];

    nixpkgs = {
      source = inputs.nixpkgs;
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        # Temporary fff-nvim libgit2 workaround; see overlays/fff-nvim.nix.
        (import ../overlays/fff-nvim.nix)
      ];
      config.allowUnfree = true;
    };
  };
}
