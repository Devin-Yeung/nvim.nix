{
  lib,
  pkgs,
  ...
}:
{
  plugins.lspconfig.enable = true;

  diagnostic.settings = {
    virtual_text.prefix = "";
    # Severity values are 1..4: a list emits numeric Lua keys.
    signs.text = [
      "󰅙"
      ""
      "󰋼"
      "󰌵"
    ];
    underline = true;
    float.border = "single";
  };

  filetype.filename = {
    "buf.yaml" = "buf-config";
    "buf.gen.yaml" = "buf-config";
    "buf.policy.yaml" = "buf-config";
    "buf.lock" = "buf-config";
  };

  lsp = {
    inlayHints.enable = true;
    codelens.enable = true;
    # Match the source's disabled semantic highlighting, using the native API.
    semanticTokens = {
      enable = true;
      activate = false;
    };

    keymaps = [
      {
        mode = "n";
        key = "gd";
        lspBufAction = "definition";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "gD";
        lspBufAction = "declaration";
        options.desc = "Go to declaration";
      }
      {
        mode = "n";
        key = "<leader>D";
        lspBufAction = "type_definition";
        options.desc = "Go to type definition";
      }
    ];

    servers = {
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
  };

  # These were global in the source, unlike the three navigation bindings above.
  keymaps = [
    {
      mode = "n";
      key = "<leader>qf";
      action = lib.nixvim.mkRaw "vim.lsp.buf.code_action";
      options.desc = "Quick fix";
    }
    {
      mode = "n";
      key = "<leader>f";
      action = lib.nixvim.mkRaw ''function() vim.diagnostic.open_float { border = "rounded" } end'';
      options.desc = "Floating diagnostic";
    }
    {
      mode = "n";
      key = "gK";
      action = lib.nixvim.mkRaw "vim.lsp.buf.signature_help";
      options.desc = "Signature help";
    }
  ];
}
