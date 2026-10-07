{
  pkgs,
  inputs,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  nvim = inputs.nixvim.legacyPackages.${system}.makeNixvim {
    imports = [ ./config ];
    # Nixvim uses its own nixpkgs instance, separate from devenv's allow_unfree.
    nixpkgs.config.allowUnfree = true;
  };
in
{
  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    nvim
  ];

  # https://devenv.sh/languages/
  languages.nix.enable = true;

  # https://devenv.sh/git-hooks/
  git-hooks.hooks.nixfmt.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
