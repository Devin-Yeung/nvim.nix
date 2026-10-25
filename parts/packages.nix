{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      # Enables `nix build .` as a standalone configuration smoke test.
      packages.default = inputs.nixvim.legacyPackages.${system}.makeNixvim (
        (import ./nixvim.nix) {
          inherit inputs;
        }
      );
    };
}
