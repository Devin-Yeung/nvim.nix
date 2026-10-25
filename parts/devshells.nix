{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [ ../devenv.nix ];
      };
    };
}
