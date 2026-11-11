{ pkgs, ... }:
let
  # Not in nixpkgs yet; pinned to a commit so the editor only changes when we bump it.
  jj-conflict-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "jj-conflict.nvim";
    version = "2026-07-02";
    src = pkgs.fetchFromGitHub {
      owner = "0xferrous";
      repo = "jj-conflict.nvim";
      rev = "ad91bf2c93578915645ca8bf70733f48516fe467";
      hash = "sha256-KNzqbJDGnCdQizNz78P2POv6YmKSvvRoZ/5PFf18KL4=";
    };

    # Neovim 0.13 removed `vim.diagnostic.disable`/per-buffer `enable(bufnr)` in
    # favour of `vim.diagnostic.enable(bool, { bufnr = ... })`. Upstream still
    # calls the old form, so rewrite it here.
    # TODO: drop this patch once upstream uses the new API.
    postPatch = ''
      substituteInPlace lua/jj-conflict.lua \
        --replace-fail 'vim.diagnostic.disable(bufnr)' 'vim.diagnostic.enable(false, { bufnr = bufnr })' \
        --replace-fail 'vim.diagnostic.enable(bufnr)' 'vim.diagnostic.enable(true, { bufnr = bufnr })'
    '';
  };
in
{
  extraPlugins = [ jj-conflict-nvim ];

  # Buffer-local keys only, set while the buffer has jj conflict markers:
  #   ]x / [x  next / previous conflict
  #   cx       resolve current conflict
  # Diagnostics are muted in conflicted buffers because the markers (and the
  # diff-style lines inside each conflict block) are not valid source code.
  extraConfigLua = ''
    require("jj-conflict").setup({
      disable_diagnostics = true,
    })
  '';
}
