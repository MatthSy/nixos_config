{...}: {
  virtualisation.oci-containers.containers = {
    sonarr = {
      image = "ghcr.io/hotio/sonarr:release";
      # ports = ["8282:8282"];
      dependsOn = ["gluetun"];
      extraOptions = [
        "--net=container:gluetun"
      ];
      environment = {
        PUID = "994"; # jellyfin UID
        PGID = "991"; # media GID
        UMASK = "002";
        TZ = "Etc/UTC";
        # WEBUI_PORTS = "8989/tcp";
      };
      volumes = [
        "/home/matt_serv/.config/nixos/hosts/serv/services/media/sonarr/config:/config"
        "/home/jellyfin/media/tv:/data"
        "/home/jellyfin/media/qbittorrent/downloads:/app/qBittorrent/downloads"
      ];
    };
  };
}
