{
  cmake,
  curl,
  fetchFromGitHub,
  json_c,
  lib,
  openssl,
  pkg-config,
  stdenv,
}:

stdenv.mkDerivation rec {
  pname = "AzureKeyVaultManagedHSMEngine";
  version = "5d212a20c8550d17b67012844d6d6d473f2d8c0f";

  src = ../src;

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [ ];

  propagatedBuildInputs = [
    curl
    json_c
    openssl
  ];

  buildPhase = ''
    runHook preBuild
    mkdir build
    cmake
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib/engines-1.1/
    mkdir -p $out/lib/engines-3/
    cp e_akv.so $out/lib/engines-1.1/e_akv.so
    cp e_akv.so $out/lib/engines-3/e_akv.so
    runHook postInstall
  '';

  meta = {
    description = "";
    downloadPage = "https://github.com/Microsoft/AzureKeyVaultManagedHSMEngine/";
  };
}
