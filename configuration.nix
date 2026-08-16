# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
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
    ./extra_cache_providers.nix
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
    "console=ttyS0,115200"
  ];
  # GPUs config :
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  services.xserver.videoDrivers = ["amdgpu"];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "nixos"; # Define your hostname.
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."matt" = {
    isNormalUser = true;
    description = "Matt";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      # Gaming related packages :
      discord
      protontricks
      vulkan-tools
      mangohud
      nvtopPackages.full
      gpustat
    ];
  };
  nix.settings.allowed-users = ["matt" "@wheel"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Main text editor
    wget
    git

    firefox # Main browser
    thunderbird # Mail client
    nemo # Main file manager
    fastfetch # System infos
    wl-clipboard # clipboard additions (used for neovim)
    btop-cuda
    htop

    # Terminal and shell related
    alacritty # Main terminal emulator
    foot # Fallback terminale emulator (not hardware accelerated)
    zsh # Shell
    oh-my-posh # Stylizer for zsh
    zip
    unzip
    xz
    fzf

    # Programming related packages :
    python313Packages.python
    luarocks # used by treesitter in neovim config
    lua5_1 # Same
    nodejs
    cargo # Rust package manager
    gcc # Toolchain for C
    livegrep #text searching

    # WM environment :
    python313Packages.pywal16
    wofi # App launcher
    hyprlock # Lockscreen
    hypridle # Idle detector, auto suspend
    hyprpaper # Wallpaper manager
    nsxiv # Image viewer, used for wallpaper selection
    waybar # Bar
    hyprshot # Screenshot tool
    brightnessctl # Screen brightness tool
    wlogout # Logout screen
    gdk-pixbuf # Used by wlogout
    bibata-cursors # Mouse cursor
    tuigreet # Greeter, display manager
  ];

  # System related :
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NH_FLAKE = "/home/matt/.config/nixos";
    NH_OS_FLAKE = "/home/matt/.config/nixos";
    NH_HOME_FLAKE = "/home/matt/.config/home-manager";
  };

  # nh : nixos helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--all --keep 10";
    flake = "/home/matt/.config/nixos";
  };

  # WM environment :
  programs.hyprland.enable = true;

  # Shell related :
  programs.zsh.enable = true;

  # Gaming related :
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    extraCompatPackages = with pkgs; [proton-ge-bin];
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

  security.pam.services.login.fprintAuth = false;

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "/run/current-system/sw/bin/tuigreet --time --cmd start-hyprland -r";
        user = "greeter";
      };
      terminal.vt = lib.mkForce 3;
    };
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
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

  # WM environment

  services.dunst = {
    # Notifications daemon
    enable = true;
    enableWayland = true;
    enableX11 = false;
  };

  # Enable SVG (patch for icons in wlogout)
  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
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
