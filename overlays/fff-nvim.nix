/*
  Workaround: nixpkgs commit 44cddf92c4 ("rustPlatform.cargoSetupHook: Force system libs")
  exports LIBGIT2_NO_VENDOR=1 for every cargo build. fff-nvim-lib depends on libgit2-sys,
  which then requires a system libgit2, but vimPlugins.fff-nvim does not provide one,
  so the build fails on aarch64-darwin.

  Fix: give the fff Rust library the system libgit2 (1.9.7, within libgit2-sys's
  required range of >=1.9.6 <1.10.0) and point the plugin's download.lua at the patched lib.

  Why an overlay and not an override: fff-nvim-lib is a private `let` binding inside
  pkgs/applications/editors/vim/plugins/non-generated/fff-nvim/default.nix, and the plugin
  bakes its store path into postPatch. We can only reach it through `passthru.fff-nvim-lib`,
  so we rewrite the store path in postPatch.

  Assumptions to re-check on each nixpkgs bump:
  - fff-nvim still exposes `passthru.fff-nvim-lib` and its postPatch references that path verbatim.
  - libgit2 in nixpkgs is still within the range required by libgit2-sys.

  TODO: remove this overlay once nixpkgs builds vimPlugins.fff-nvim without the workaround.
*/
final: prev: {
  vimPlugins = prev.vimPlugins.extend (
    _: previousPlugins:
    let
      upstreamFff = previousPlugins.fff-nvim;
      upstreamLib = upstreamFff.fff-nvim-lib;
      patchedLib = upstreamLib.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ prev.libgit2 ];
      });
    in
    {
      fff-nvim = upstreamFff.overrideAttrs (old: {
        # replaceStrings only rewrites the text; the old string context would still pull the
        # unpatched lib in as a build input. Drop it first so only the patched lib is referenced.
        postPatch = prev.lib.replaceStrings [ "${upstreamLib}" ] [ "${patchedLib}" ] (
          builtins.unsafeDiscardStringContext old.postPatch
        );
        passthru = old.passthru // {
          fff-nvim-lib = patchedLib;
        };
      });
    }
  );
}
