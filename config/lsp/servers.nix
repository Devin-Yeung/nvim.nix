{
  lib,
  pkgs,
  ...
}:
{
  filetype.filename = {
    "buf.yaml" = "buf-config";
    "buf.gen.yaml" = "buf-config";
    "buf.policy.yaml" = "buf-config";
    "buf.lock" = "buf-config";
  };

  lsp.servers = {
    html.enable = true;
    cssls.enable = true;
    jsonls.enable = true;
    lua_ls = {
      enable = true;
      config.settings.Lua = {
        runtime.version = "LuaJIT";
        workspace.library = [
          (lib.nixvim.mkRaw ''vim.fn.expand "$VIMRUNTIME/lua"'')
          "\${3rd}/luv/library"
        ];
      };
    };
    clangd.enable = true;
    rust_analyzer.enable = true;
    nixd.enable = true;
    ocamllsp = {
      enable = true;
      config.settings = {
        inlayHints.enable = true;
        codelens.enable = true;
      };
    };
    tombi.enable = true;
    yamlls.enable = true;
    marksman.enable = true;
    r_language_server = {
      enable = true;
      package = pkgs.rWrapper.override { packages = [ pkgs.rPackages.languageserver ]; };
    };
    basedpyright.enable = true;
    gopls.enable = true;
    jsonnet_ls.enable = true;
    nushell.enable = true;
    buf_ls.enable = true;
  };
}
