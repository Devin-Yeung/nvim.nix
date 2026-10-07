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
          (lib.nixvim.mkRaw /* lua */ ''vim.fn.expand "$VIMRUNTIME/lua"'')
          "\${3rd}/luv/library"
        ];
      };
    };
    clangd = {
      enable = true;
      # avoid bringing in llvm closure
      package = null;
    };
    rust_analyzer = {
      enable = true;
      # prefer rustup's rust_analyzer
      package = null;
    };
    nixd.enable = true;
    tombi.enable = true;
    yamlls.enable = true;
    marksman.enable = true;
    basedpyright.enable = true;
    gopls.enable = true;
    jsonnet_ls.enable = true;
    nushell.enable = true;
    buf_ls.enable = true;
  };
}
