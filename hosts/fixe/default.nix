{...}: {
  imports = [
    ../common/graphical.nix
    ../common/gaming.nix
  ];

  services.xserver.videoDrivers = ["amdgpu"];

  networking.hostName = "fixe"; # Define your hostname.
}
