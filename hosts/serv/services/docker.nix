{...}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "overlay2";

    daemon.settings = {
      userland-proxy = false;
    };

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  virtualisation.oci-containers.backend = "podman";

  # Example for oci-containers :
  virtualisation.oci-containers.containers = {
    #   my-caddy = {
    #     image = "my-caddy:latest";
    #     ports = ["8080:80"];
    #
    #     imageStream = pkgs.dockerTools.streamLayeredImage {
    #       name = "my-caddy";
    #       tag = "latest";
    #
    #       contents = [
    #         pkgs.caddy
    #         pkgs.cacert
    #       ];
    #
    #       extraCommands = ''
    #         mkdir -p tmp var/tmp
    #       '';
    #
    #       config = {
    #         Cmd = [
    #           "${pkgs.caddy}/bin/caddy"
    #           "file-server"
    #           "--browse"
    #           "--listen"
    #           ":80"
    #         ];
    #         WorkingDir = "/";
    #         ExposedPorts = {
    #           "80/tcp" = {};
    #         };
    #       };
    #     };
    #   };
  };
}
