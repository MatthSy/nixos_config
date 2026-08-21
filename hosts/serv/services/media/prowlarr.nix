{...}: {
  virtualisation.oci-containers.containers = {
    prowlarr = {
      image = "ghcr.io/hotio/prowlarr";
      dependsOn = ["gluetun"];

      extraOptions = [
        "--network=container:gluetun"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "Etc/UTC";
      };
      volumes = [
        "/home/jellyfin/media/prowlarr:/config"
      ];
    };
  };
}
