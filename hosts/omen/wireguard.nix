{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  age.secrets.wg-key-peer0 = {
    file = ./.secrets/wg-key-peer0.age;
  };

  networking.firewall.allowedUDPPorts = [51820];

  networking.wg-quick.interfaces.wg0 = {
    autostart = false; # only up on demand

    address = ["192.168.1.101/32"];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wg-key-peer0.path;

    peers = [
      {
        # Serveur
        publicKey = "ejmbag/fcc9OLp8K62zfV0NCbp056DnA0qpNixLXwCo=";
        allowedIPs = [
          "88.161.174.31/32"
        ];
        endpoint = "88.161.174.31:51820";
        persistentKeepalive = 25;
      }
    ];
  };
}
