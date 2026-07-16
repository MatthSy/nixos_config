{pkgs, ...}: {
  imports = [
    ../../home/hyprland
    ../../home/temp.nix
    ../../home/core.nix
  ];

  programs.git = {
    enable = true;
    userName = "MatthSy";
    userEmail = "matthieu.symphorien@edu.ece.fr";
  };
}
