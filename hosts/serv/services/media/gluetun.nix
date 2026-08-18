{...}: {
  virtualisation.oci-containers.containers = {
    gluetun = {
      image = "qmcgaw/gluetun:latest";
      # ports = [""];
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
