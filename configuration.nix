{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "u210";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";
  console.keyMap = "ruwin_cpl";

  services.openssh.enable = true;

  users.users.oleg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    password = "1234"; # измени после установки
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    rofi
    polybar
    qutebrowser
    ranger
    pcmanfm
    bspwm
    sxhkd
    dmenu
    alacritty
    feh
    lxappearance
    papirus-icon-theme
    gruvbox
    unzip
    htop
  ];

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.bspwm.enable = true;
    windowManager.bspwm.package = pkgs.bspwm;
  };

  programs.sxhkd.enable = true;

  fonts.packages = with pkgs; [
    nerdfonts
    terminus_font
  ];

  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  system.stateVersion = "24.05";
}
