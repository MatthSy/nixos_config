{lib, ...}: {
  hardware.graphics.enable = lib.mkDefault true;

  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "/run/current-system/sw/bin/tuigreet --time --cmd start-hyprland -r";
        user = "greeter";
      };
      # terminal.vt = lib.mkForce 3;
    };
  };

  services.upower.enable = true;
}
