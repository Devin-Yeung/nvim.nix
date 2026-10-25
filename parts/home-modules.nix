{ inputs, ... }:
let
  nixvim = (import ./nixvim.nix) {
    inherit inputs;
  };
in
{
  flake.homeModules.default = {
    imports = [ inputs.nixvim.homeModules.nixvim ];
    programs.nixvim = nixvim;
  };
}
