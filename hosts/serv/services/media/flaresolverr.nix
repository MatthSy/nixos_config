{...}: {
  virtualisation.oci-containers.containers = {
    flaresolverr = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      dependsOn = ["gluetun"];
      extraOptions = [
        "--network=container:gluetun"
      ];
      environment = {
        LOG_LEVEL = "info";
        TZ = "Etc/UTC";
      };
    };
  };
}
