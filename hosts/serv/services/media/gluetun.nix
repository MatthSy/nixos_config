{...}: {
  virtualisation.oci-containers.containers = {
    gluetun = {
      image = "docker.io/qmcgaw/gluetun:latest";
      ports = [
        "8181:8181" # qBittorrent
        "8282:8989" # Sonarr
        "8383:7878" # Radarr
        "9696:9696" # Prowlarr
      ];
      # cmd = [""];
      # Add required kernel capabilities and tun device
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--device=/dev/net/tun:/dev/net/tun"
        "--cap-add=NET_RAW"
      ];
      environment = {
        VPN_SERVICE_PROVIDER = "protonvpn";
        VPN_TYPE = "wireguard";
        WIREGUARD_PRIVATE_KEY = "eObDG5TmIXvS/TbA9RqFkOuj1yg06gdiW4WC4unlymQ=";
        SERVER_COUNTRIES = "france";
        PORT_FORWARD_ONLY = "on";
        VPN_PORT_FORWARDING = "on";
        FIREWALL_OUTBOUND_SUBNETS = "192.168.1.0/24";
      };
    };
  };
}
