{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "loglevel=0"
    "systemd.show_status=false"
    # "console=ttyS0,115200"
  ];

  # Might move to host specific config later
  nix.settings = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    experimental-features = ["nix-command" "flakes"];
  };

  networking.hostName = lib.mkDefault "matt_nix"; # Define your hostname.
  #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  nix.settings.allowed-users = lib.mkDefault ["matt" "@wheel"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Main text editor
    git
    tuigreet # greeter
    nano

    # Terminal and shell related
    foot # Fallback terminal emulator (not hardware accelerated)
    zsh # Shell
  ];

  # System related :
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "kitty nvim";
    NH_FLAKE = lib.mkDefault "/home/matt/.config/nixos";
    NH_OS_FLAKE = lib.mkDefault "/home/matt/.config/nixos";
    NH_HOME_FLAKE = lib.mkDefault "/home/matt/.config/home-manager";
  };

  # nh : nixos helper
  programs.nh = {
    enable = true;
    # clean.enable = true;
    clean.extraArgs = lib.mkDefault "all --keep 5";
    flake = lib.mkDefault "/home/matt/.config/nixos";
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # System related :

  # Disable finger print auth, prevent from black screen on session opening
  security.pam.services.login.fprintAuth = false;

  services.auto-cpufreq = {
    enable = lib.mkDefault true;
    settings = lib.mkDefault {
      charger = {
        governor = "performance";
        energy_performance_preference = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        energy_performance_preference = "power";
        turbo = "auto";
      };
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    53317 # Port for the localsend app
  ];
  networking.firewall.allowedUDPPorts = [
    53317 # Port for the localsend app
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
