{pkgs, ...}: {
  virtualisation.oci-containers.containers = {
    dashy = {
      image = "lissy93/dashy:latest";
      ports = ["8080:8080"];
      volumes = [
        "/home/matt_serv/dashy:/app/user-data"
        "/home/matt_serv/.config/nixos/hosts/serv/services/dashy/conf.yml:/app/user-data/conf.yml"
      ];
    };
  };
}
