{
  pkgs,
  lib,
  ...
}: {
  assertions = [
    {
      assertion = true;
      message = "UPDATE HARDWARE CONFIG BEFORE SWITCH";
    }
  ];
  imports = [
    ./hardware-configuration.nix

    # services/docker.nix
    services/podman.nix
    services/dashy
    services/media/gluetun.nix

    # Services to add :
    # wireguard ?
    # Sonarr & radarr + nzbget
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
    extraGroups = ["networkmanager" "wheel" "media"];
    # packages = with pkgs; [
    # ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  networking.networkmanager.wifi.powersave = false;

  services.openssh.enable = true;

  # Disable suspend when lid closed
  services.logind.settings.Login = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
  };

  # Disable if using custom power tools, or configure explicitly:
  powerManagement.enable = false;
  systemd = {
    targets.sleep.enable = false;
    targets.suspend.enable = false;
    targets.hibernate.enable = false;
    targets.hybrid-sleep.enable = false;
  };
  networking.interfaces.wlp3s0.wakeOnLan.enable = true;

  # System related :
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "kitty nvim";
    NH_FLAKE = "/home/matt_serv/.config/nixos";
    NH_OS_FLAKE = "/home/matt_serv/.config/nixos";
    NH_HOME_FLAKE = "/home/matt_serv/.config/home-manager";
  };

  # nh : nixos helper
  programs.nh = {
    enable = true;
    # clean.enable = true;
    clean.extraArgs = "all --keep 5";
    flake = "/home/matt_serv/.config/nixos";
  };
}
