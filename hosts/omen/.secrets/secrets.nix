let
  matt = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGi7ydy2aKhvatKVt60jeOaOf6QhUUxJZImvuVedvSig matt@nixos";
  omen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHO6kTm1Hm11VTRJ/vDgG+D40yPnNSPH170B0etcm454 root@omen";
in {
  "wg-key-peer0.age".publicKeys = [matt omen];
}
