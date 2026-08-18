{...}: {
  virtualisation.oci-containers.containers = {
    gluetun = {
      image = "ghcr.io/hotio/sonarr:release";
      ports = ["8989:8989"];
      cmd = [
        ""
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "Etc/UTC";
        WEB_UI_PORT = "8989:tcp";
      };
      volumes = [
        "/home/matt_serv/.config/nixos/hosts/serv/services/media/sonarr/config:/config"
        "/home/jellyfin/data/media/tv:/data"
      ];
    };
  };
}
