{pkgs, ...}: {
  imports = [
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

  # GPUs config :
  hardware.nvidia = {
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      amdgpuBusId = "PCI:7@0:0:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
    open = false;
    modesetting.enable = true;
  };

  services.xserver.videoDrivers = ["amdgpu" "nvidia"];

  networking.hostName = "omen"; # Define your hostname.

  #Gaming
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override {
        extraArgs = "-cef-disable-gpu-compositing";
      };
    })
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports for Source Dedicated Server hosting
    extraCompatPackages = with pkgs; [proton-ge-bin];
  };
}
