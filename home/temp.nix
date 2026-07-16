{ config, pkgs, ... }:

{
  home = {
    home.packages = with pkgs; [
      firefox # Main browser
      thunderbird # Mail client
      nemo # Main file manager
      alacritty # Main terminal emulator
      python313Packages.python
      luarocks # used by treesitter in neovim config
      lua5_1 # Same
      nodejs
      cargo # Rust package manager
      livegrep #text searching
      neovim # Main text editor 
    ];

  };
}
