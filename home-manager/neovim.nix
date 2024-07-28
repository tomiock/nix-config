{ config, pkgs, inputs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      -- lua code
      ${buildins.readFile /home/tominix/.config/nvim/init.lua}
    '';
  };
}
