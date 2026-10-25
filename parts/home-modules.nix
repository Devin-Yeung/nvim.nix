{ config, inputs, ... }:
{
  flake.homeModules.default = {
    imports = [ inputs.nixvim.homeModules.nixvim ];
    programs.nixvim = config.flake.nixvimModules.default;
  };
}
