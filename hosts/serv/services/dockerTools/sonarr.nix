{
  pkgs ? import <nixpkgs> {},
  pkgsLinux ? import <nixpkgs> {system = "x86_64-linux";},
}:
pkgs.dockerTools.buildImage {
  name = "sonarr";
  config = {
    Cmd = ["${pkgsLinux.sonarr}/bin/sonarr"];
  };
}
