{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/graphical.nix
    ../common/gaming.nix

    # Specialisations :
    ../../specialisations/dev
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."matt" = {
    isNormalUser = true;
    description = "Matt";
    extraGroups = ["networkmanager" "wheel"];
    # packages = with pkgs; [
    # ];
  };

  services.xserver.videoDrivers = ["amdgpu"];

  networking.hostName = "fixe"; # Define your hostname.

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports for Source Dedicated Server hosting
    extraCompatPackages = with pkgs; [proton-ge-bin];
  };

  services.lact.enable = true; # For GPU settings
}
