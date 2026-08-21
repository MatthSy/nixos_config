{...}: {
  virtualisation.oci-containers.containers = {
    qbittorrent = {
      image = "ghcr.io/hotio/qbittorrent";
      dependsOn = ["gluetun"];
      # ports = ["8181:8080"];
      extraOptions = [
        "--net=container:gluetun"
      ];
      environment = {
        PUID = "994"; # jellyfin UID
        PGID = "991"; # media GID
        UMASK = "002";
        TZ = "Etc/UTC";
        LIBTORRENT = "v1";
        WEBUI_PORTS = "8181/tcp";
        QBT_LEGAL_NOTICE = "confirm";
      };
      volumes = [
        "/home/matt_serv/.config/nixos/hosts/serv/services/media/qbittorrent/config:/config"
        "/home/jellyfin/media/qbittorrent:/app/qBittorrent"
        "/home/jellyfin/media/qbittorrent/downloads:/app/qBittorrent/downloads"
      ];
    };
  };
}
