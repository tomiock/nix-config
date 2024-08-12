{ config, pkgs, inputs, lib, ... }:
{
  home.packages = [
    pkgs.nil # TODO: install with flakes
    pkgs.python311Packages.python-lsp-server
    pkgs.luajitPackages.lua-lsp
    pkgs.luajitPackages.luarocks
    pkgs.tree-sitter
    pkgs.nodejs_22
    pkgs.rocmPackages_5.llvm.clang-tools-extra
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.gopls
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
