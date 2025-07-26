{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # замени sdX на свой диск (например, /dev/sda)
  boot.supportedFilesystems = [ "btrfs" ];

  networking.hostName = "nix";
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "ru_RU.UTF-8";

  console = {
    keyMap = "ruwin_cpl";
    font = "Lat2-Terminus16";
  };

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle";
    displayManager.startx.enable = true;
    windowManager.bspwm.enable = true;
  };

  users.users.oleg = {
    isNormalUser = true;
    description = "Олег";
    extraGroups = [ "wheel" "networkmanager" ];
    password = "tronik"; # ЗАМЕНИ потом через `passwd`
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    rofi
    polybar
    sxhkd
    pcmanfm
    ranger
    alacritty
    bspwm
    feh
    unzip
    qutebrowser
    lxappearance
    gruvbox
  ];

  services.openssh.enable = true;

  system.stateVersion = "24.05";
}