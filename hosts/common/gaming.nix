{pkgs, ...}: {
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
