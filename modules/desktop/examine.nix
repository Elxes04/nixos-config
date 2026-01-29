{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, libcosmicAppHook
, pkg-config
, just
, openssl
, wayland
, libxkbcommon
}:

rustPlatform.buildRustPackage rec {
  pname = "examine";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "examine";
    rev = "v${version}";
    hash = ""
  };

  useFetchCargoVendor = true;
  cargoHash = "";

  # Gestione dipendenze Git nel Cargo.lock
  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "etc-os-release-0.1.1" = "";
      "libcosmic-0.0.0" = "";
    };
  };

  nativeBuildInputs = [
    just
    pkg-config
    libcosmicAppHook
  ];

  buildInputs = [
    openssl
    wayland
    libxkbcommon
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/${pname}"
  ];

  meta = with lib; {
    description = "A system information viewer for the COSMIC Desktop";
    homepage = "https://github.com/cosmic-utils/examine";
    license = licenses.gpl3Only;
    maintainers = [ ]; # Aggiungi il tuo nome qui
    mainProgram = "examine";
    platforms = platforms.linux;
  };
}
