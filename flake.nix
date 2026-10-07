{
  description = "A batteries-included Nixvim configuration";

  inputs = {
    # Nixvim main and the nightly Neovim overlay both track this package set.
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      neovim-nightly-overlay,
      flake-utils,
      ...
    }:
    let
      nixvimConfig = {
        imports = [ ./config ];

        # Keep the config, Nixvim module, and its package set in one lock file.
        nixpkgs = {
          source = nixpkgs;
          overlays = [ neovim-nightly-overlay.overlays.default ];
          config.allowUnfree = true;
        };
      };

      nixvimModule = {
        imports = [ nixvim.homeModules.nixvim ];
        programs.nixvim = nixvimConfig;
      };
    in
    (flake-utils.lib.eachSystem
      [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ]
      (system: {
        # Enables `nix build .` as a standalone configuration smoke test.
        packages.default = nixvim.legacyPackages.${system}.makeNixvim nixvimConfig;
      })
    )
    // {
      homeModules.default = nixvimModule;
    };
}
