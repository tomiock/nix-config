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

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub = {
	enable = true;
        #efiSupport = true;
        device = "/dev/nvme0n1/";
        useOSProber = true;
  };

  hardware.cpu.amd.ryzen-smu.enable = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = {
    enable = true;
    #driSupport = true;
    #driSupport32Bit = true;
  };

  programs.hyprland.enable = true;
  programs.sway.enable = true;

  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    #xdg-desktop-portal-kde
    xdg-desktop-portal-gtk
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "zeus"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
    #alsa.enable = true;
    #alsa.support32Bit = true;
    pulse.enable = true;
  };

  console.keyMap = "us";

  users.users.tomiock = {
    isNormalUser = true;
    description = "tomiock";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  users.users.nixremote = {
    description = "nix remote builder";
    isSystemUser = true;
    createHome = false;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNG3suP9wJk8IgVLxx1k5vjdH5KyJIk5yI3cJ2cLuuH tomiock@atenea"
      "ssh-ed25519 AAAAC3NZaC1lZDI1NTE5AAAAINRFN/t13rzC9b10hnFeXUMIaIM8Do0oAZ5h8+nT8/kP root@atenea" 
    ];

    uid = 500;
    group = "nixremote";
    useDefaultShell = true;
  };

  users.groups.nixremote = {
    gid = 500;
  };

  nix.settings.trusted-users = ["nixremote"];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    vim
    neovim
    firefox
    #obsidian # disable GPU acc

    # hardware
    ryzen-monitor-ng # usage 'sudo ryzen_monitor'
    microcodeAmd

    # Dev Utils
    git
    bottom
    ranger
    wget
    tldr
    unzip

    # Dev
    go
    gcc
    cargo
    rustup
    python3
    qemu

    # System
    dmenu
    grim
    slurp
    swaylock
    wl-clipboard
    wf-recorder

    pkgs.kdiskmark

    qt6.qtwayland
    qt5.qtwayland
    #    libsForQt5.qtstyleplugin-kvantum

    pavucontrol
    libnotify
    filelight

    quickemu
    pika-backup
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # do NOT CHANGE
  system.stateVersion = "24.05"; # Did you read the comment?

}
