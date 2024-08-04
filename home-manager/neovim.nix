{ config, pkgs, inputs, lib, ... }:
{
  home.packages = [
    pkgs.nil
    pkgs.python311Packages.python-lsp-server
    pkgs.luajitPackages.lua-lsp
    pkgs.luajitPackages.luarocks
    pkgs.tree-sitter
    pkgs.nodejs_22
  ];

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
