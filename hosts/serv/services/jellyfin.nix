{...}: {
  users.users."jellyfin" = {
    isNormalUser = false;
    extraGroups = ["media"];
  };
  users.groups.media = {};

  services.jellyfin = {
    enable = true;
    openFirewall = true;

    user = "jellyfin";
    group = "media";

    dataDir = "/home/jellyfin/data";
  };
}
