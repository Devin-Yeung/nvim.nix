{ lib, ... }:
{
  lsp.keymaps = [
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

  # These were global in the source, unlike the three navigation bindings above.
  keymaps = [
    {
      mode = "n";
      key = "<leader>qf";
      action = lib.nixvim.mkRaw /* lua */ "vim.lsp.buf.code_action";
      options.desc = "Quick fix";
    }
    {
      mode = "n";
      key = "<leader>f";
      action = lib.nixvim.mkRaw /* lua */ ''function() vim.diagnostic.open_float { border = "rounded" } end'';
      options.desc = "Floating diagnostic";
    }
    {
      mode = "n";
      key = "gK";
      action = lib.nixvim.mkRaw /* lua */ "vim.lsp.buf.signature_help";
      options.desc = "Signature help";
    }
  ];
}
