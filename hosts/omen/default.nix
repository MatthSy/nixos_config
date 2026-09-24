{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix

    ../common/graphical.nix
    ../common/gaming.nix

    # Specialisations :
    ../../specialisations/dev
  ];

  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];

  environment.systemPackages = with pkgs; [
    cisco-packet-tracer_9
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."matt" = {
    isNormalUser = true;
    description = "Matt";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
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

  # cisco-packet-tracer_9
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      packettracer9 = {
        executable = lib.getExe pkgs.cisco-packet-tracer_9;

        # Will still want a .desktop entry as the package is not directly added
        # desktop = "${pkgs.cisco-packet-tracer_9}/share/applications/cisco-packet-tracer_9.desktop";

        extraArgs = [
          # This should make it run in isolated netns, preventing internet access
          "--net=none"

          # firejail is only needed for network isolation so no futher profile is needed
          "--noprofile"

          # Packet tracer doesn't play nice with dark QT themes so this
          # should unset the theme. Uncomment if you have this issue.
          ''--env=QT_STYLE_OVERRIDE=""''
        ];
      };
    };
  };

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
