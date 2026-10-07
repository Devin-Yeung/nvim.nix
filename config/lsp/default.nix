{
  imports = [
    ./diagnostics.nix
    ./keymaps.nix
    ./servers.nix
  ];

  plugins.lspconfig.enable = true;

  lsp = {
    inlayHints.enable = true;
    codelens.enable = true;
    # Match the source's disabled semantic highlighting, using the native API.
    semanticTokens = {
      enable = true;
      activate = false;
    };
  };
}
