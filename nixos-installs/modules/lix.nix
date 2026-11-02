{ lib, pkgs, ... }: {
  nix.package = pkgs.lix.overrideAttrs (old: {
    mesonFlags = lib.filter (flag: !(lib.hasPrefix "-Dmimalloc=" flag)) old.mesonFlags;
  });
}
