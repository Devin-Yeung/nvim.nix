{
  globals.mapleader = "\\";

  opts = {
    laststatus = 3;
    showmode = false;
    splitkeep = "screen";
    clipboard = "unnamedplus";
    cursorline = true;
    cursorlineopt = "number";
    expandtab = true;
    shiftwidth = 2;
    smartindent = true;
    tabstop = 2;
    softtabstop = 2;
    fillchars.eob = " ";
    ignorecase = true;
    smartcase = true;
    mouse = "a";
    number = true;
    numberwidth = 2;
    ruler = false;
    shortmess = "ltToOCFsI";
    signcolumn = "yes";
    splitbelow = true;
    splitright = true;
    timeoutlen = 400;
    undofile = true;
    updatetime = 250;
    whichwrap = "b,s,<,>,[,],h,l";
  };

  # These providers were disabled in the source configuration.
  withNodeJs = false;
  withPython3 = false;
  withPerl = false;
  withRuby = false;
}
