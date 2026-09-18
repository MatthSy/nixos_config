{
  lib,
  pkgs,
  ...
}: {
  specialisation.dev.configuration = {
    imports = [
    ];

    environment.systemPackages = with pkgs; [
      gcc

      lazydocker
      # nodejs
      devenv
    ];

    virtualisation.virtualbox.host = {
      enable = true;
      # enableKvm = true;
    };
    # virtualisation.vmware.host = {
    #   enable = true;
    #   # enableKvm = true;
    # };
    virtualisation.libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    programs.virt-manager.enable = true;
    users.extraGroups.vboxusers.members = ["matt"];

    virtualisation.podman = {
      enable = true;
      # enableOnBoot = true;
      # storageDriver = "overlay2";

      # daemon.settings = {
      #   userland-proxy = false;
      # };

      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };

    # virtualisation.oci-containers.backend = "docker";

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
