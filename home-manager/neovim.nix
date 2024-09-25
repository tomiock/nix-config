{ config, pkgs, inputs, lib, ... }:
{
  home.packages = [
    pkgs.luajitPackages.luarocks
    pkgs.tree-sitter
    pkgs.nodejs_22

    # LSPs
    pkgs.rocmPackages_5.llvm.clang-tools-extra
    pkgs.nil # TODO: install with flakes
    pkgs.lua-language-server
    pkgs.python311Packages.python-lsp-server
    pkgs.luajitPackages.lua-lsp
    pkgs.rust-analyzer
    pkgs.gopls
    pkgs.pyright
    pkgs.markdown-oxide

    pkgs.libcaca # SURF
    pkgs.mplayer #
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
