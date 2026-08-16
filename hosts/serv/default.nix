{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../hardware-configuration.nix

    services/docker.nix
    services/dashy
    # Services to add :
    # wireguard ?
    # Sonarr & radarr
    # Jellyseerr
    # Jellyfin
    # Nextcloud or Syncthing
    # nginx proxy manager and nginx
    # grafan + prometheus
    # Gluetun + proton vpn for sonarr radarr
  ];

  users.users."matt_serv" = {
    isNormalUser = true;
    description = "Main wheel user";
    extraGroups = ["networkmanager" "wheel" "docker"];
    # packages = with pkgs; [
    # ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Might move to host specific config later
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  networking.hostName = "serv"; # Define your hostname.
  #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
}
