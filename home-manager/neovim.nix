{ config, pkgs, inputs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      # Language server packages (executables)
      lua-language-server
      rust-analyzer
      gopls
    ];
  };
}
