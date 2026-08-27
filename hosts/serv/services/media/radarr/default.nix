{...}: {
  virtualisation.oci-containers.containers = {
    radarr = {
      image = "ghcr.io/hotio/radarr:release";
      dependsOn = ["gluetun"];
      extraOptions = [
        "--net=container:gluetun"
      ];
      environment = {
        PUID = "994"; # jellyfin UID
        PGID = "991"; # media GID
        UMASK = "002";
        TZ = "Etc/UTC";
      };
      volumes = [
        "/home/matt_serv/.config/nixos/hosts/serv/services/media/radarr/config:/config"
        "/home/jellyfin/media/films:/data"
        "/home/jellyfin/media/qbittorrent/downloads:/app/qBittorrent/downloads"
      ];
    };
  };
}
