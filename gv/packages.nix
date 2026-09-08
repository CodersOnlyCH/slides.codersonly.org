{
  pkgs,
  stdenv,
  ...
}: let
  mkSlides = {date, ...}: let
    inherit (pkgs.callPackage ../marp/themes/packages.nix {}) codersonly-marp-theme;
    version = builtins.replaceStrings ["-"] ["."] date;
  in
    stdenv.mkDerivation {
      inherit version;
      pname = "codersonly-gv";
      src = ./.;
      buildInputs = with pkgs; [
        codersonly-marp-theme
        marp-cli
      ];
      buildPhase = ''
        marp --theme-set ${codersonly-marp-theme} \
             --theme codersonly \
              ${date}.md
      '';
      installPhase = ''
        mkdir -p $out
        cp -r ${codersonly-marp-theme}/* $out
        cp ${date}.html $out
      '';
    };
in {
  gv-2025 = mkSlides {date = "2025";};
  gv-2025-06-24 = mkSlides {date = "2025-06-24";};
  gv-2026 = mkSlides {date = "2026";};
  gv-2026-09-08 = mkSlides {date = "2026-09-08";};
}
