{ config, inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      packages.default =
        inputs.nixvim.legacyPackages.${system}.makeNixvim
          config.flake.nixvimModules.default;
    };
}
