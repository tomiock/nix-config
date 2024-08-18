# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../system_nixos.nix
      inputs.home-manager.nixosModules.home-manager
    ];
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
    };
  };

  programs.hyprland.enable = true;
  programs.sway.enable = true;

  hardware.graphics = {
    enable = true;
    #driSupport = true;
    #driSupport32Bit = true;
  };

  xdg.portal = {
    wlr = {
      enable = true;
    };
  };

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    #xdg-desktop-portal-wlr
    #xdg-desktop-portal-kde
    #xdg-desktop-portal-gtk
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "atenea"; # Define your hostname.

  nix.buildMachines = [{
    hostName = "nixremote@zeus";
    system = "x86_64-linux";

    sshKey = "/home/tomiock/.ssh/nixremote";

    protocol = "ssh-ng";
    maxJobs = 12;
    speedFactor = 1;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    mandatoryFeatures = [ ];
  }];

  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.ssh.extraConfig = ''
Host zeus
    Port 22
    User nixremote
    IdentitiesOnly yes
    IdentityFile ~/.ssh/nixremote
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  console.keyMap = "us";

  users.users.tomiock = {
    isNormalUser = true;
    description = "tomiock";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    vim
    neovim
    firefox

    # Dev Utils
    git
    bottom
    ranger
    wget
    tldr
    unzip

    # Dev
    go
    cargo
    rustup
    gcc
    zig
    python3

    # System
    dmenu
    grim
    slurp
    swaylock
    wl-clipboard
    wf-recorder

    qt6.qtwayland
    qt5.qtwayland
    libsForQt5.qtstyleplugin-kvantum

    pavucontrol
    libnotify
    filelight
  ];

  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # do NOT CHANGE
  system.stateVersion = "24.05"; # Did you read the comment?
}
