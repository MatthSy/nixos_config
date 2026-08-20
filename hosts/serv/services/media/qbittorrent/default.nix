{...}: {
  virtualisation.oci-containers.containers = {
    qbittorrent = {
      image = "ghcr.io/hotio/qbittorrent";
      ports = ["8080:8080"];
      cmd = [
        "--net=container:podman-gluetun"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "Etc/UTC";
        LIBTORRENT = "v1";
        WEB_UI_PORT = "8080:tcp";
        QBT_LEGAL_NOTICE = "confirm";
      };
      volumes = [
        "/home/matt_serv/.config/nixos/hosts/serv/services/media/qbittorrent/config:/config"
        "/home/jellyfin/data/media/qbittorrent:/data"
      ];
    };
  };
}
