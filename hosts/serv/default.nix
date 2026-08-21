{
  pkgs,
  lib,
  config,
  ...
}: {
  networking.firewall.allowedTCPPorts = [
    8080
    8181
    8282
    9696 # Prowlarr
  ];

  imports = [
    ./hardware-configuration.nix

    # services/docker.nix
    services/podman.nix
    services/dashy
    services/media/gluetun.nix
    services/media/jellyfin.nix
    services/media/sonarr
    services/media/qbittorrent
    services/media/prowlarr.nix
    services/media/flaresolverr.nix

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
    packages = with pkgs; [
      btop-cuda
    ];
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
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "ignore";
        IdleAction = "ignore";
        HandleSuspendKey = "ignore";
        HandleHibernateKey = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
      };
    };
  };

  # Disable if using custom power tools, or configure explicitly:
  powerManagement.enable = false;
  systemd = {
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };
  networking.interfaces.wlp3s0.wakeOnLan.enable = true;

  hardware.nvidia = {
    # Imposer la version 470xx requise pour Kepler (K2100M)
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

    # Modesetting est requis
    modesetting.enable = true;

    # Pas de gestion d'énergie avancée sur cette génération
    powerManagement.enable = false;
    open = false; # La version 'open' ne supporte pas Kepler

    # Configuration NVIDIA Prime (Offload Mode)
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # Fournit la commande `nvidia-offload`
      };

      # Bus ID à vérifier impérativement (voir étape ci-dessous)
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

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
