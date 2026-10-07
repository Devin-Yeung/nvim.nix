{
  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;

    settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
        lua = [ "stylua" ];
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
        rust = [ "rustfmt" ];
        go = [ "gofmt" ];
        ocaml = [ "ocamlformat" ];
        python = [ "ruff_format" ];
        r = [ "styler" ];
        jsonnet = [ "jsonnetfmt" ];
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        zsh = [ "shfmt" ];

        html = [ "prettier" ];
        css = [ "prettier" ];
        javascript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescript = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        json = [ "prettier" ];
        jsonc = [ "prettier" ];
        yaml = [ "prettier" ];
        markdown = [ "prettier" ];
      };

      # Use a dedicated formatter where configured; otherwise defer to the LSP.
      format_on_save = {
        timeout_ms = 1000;
        lsp_format = "fallback";
      };
    };
  };
}
