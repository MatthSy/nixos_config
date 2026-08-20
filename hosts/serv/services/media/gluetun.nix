{...}: {
  virtualisation.oci-containers.containers = {
    gluetun = {
      image = "qmcgaw/gluetun:latest";
      ports = ["8989:8989" "8181:8080"];
      cmd = [""];
      environment = {
        VPN_SERVICE_PROVIDER = "protonvpn";
        VPN_TYPE = "wireguard";
        WIREGUARD_PRIVATE_KEY = "eObDG5TmIXvS/TbA9RqFkOuj1yg06gdiW4WC4unlymQ=";
        SERVER_COUNTRIES = "france";
        PORT_FORWARD_ONLY = "on";
        VPN_PORT_FORWARDING = "on";
      };
    };
  };
}
