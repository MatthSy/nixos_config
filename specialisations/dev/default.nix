{pkgs, ...}: {
  specialisation.dev.configuration = {
    imports = [
    ];

    environment.systemPackages = with pkgs; [
      gcc

      lazydocker
    ];

    virtualisation.podman = {
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

    # virtualisation.oci-containers.backend = "docker";
  };
}
