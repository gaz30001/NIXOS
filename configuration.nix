# /etc/nixos/configuration.nix
# Конфигурация для ноутбука с AMD Athlon Neo MV-40 и ATI Radeon Xpress 1200 (ИСПРАВЛЕННАЯ)

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # --- Загрузчик GRUB для системы с BIOS (Non-EFI) ---
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  # --- Сеть ---
  networking.hostName = "nixos-athlon";
  networking.networkmanager.enable = true;

  # --- Локализация и время ---
  time.timeZone = "Europe/Moscow";

  # ИСПРАВЛЕННАЯ СТРОКА:
  i18n.defaultLocale = "ru_RU.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "ru";
  };

  # --- Пользователь oleg ---
  users.users.oleg = {
    isNormalUser = true;
    description = "Oleg";
    initialPassword = "tronik";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # --- Графическая подсистема (Xorg) ---
  services.xserver = {
    enable = true;
    videoDrivers = [ "ati" ];
    windowManager.bspwm.enable = true;
    displayManager.none = true;
    startxatlogin = true;
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };
  
  # --- Пакеты ---
  environment.systemPackages = with pkgs; [
    git
    neovim
    unzip
    bspwm
    sxhkd
    polybar
    rofi
    pcmanfm
    ranger
    alacritty
    feh
    dmenu
    qutebrowser
  ];

  # --- Шрифты ---
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    noto-fonts
    noto-fonts-emoji
  ];

  # --- Alacritty (терминал) с темой Gruvbox ---
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { family = "FiraCode Nerd Font"; style = "Regular"; };
        size = 11;
      };
      colors = {
        primary = { background = "#282828"; foreground = "#ebdbb2"; };
        normal = { black = "#282828"; red = "#cc241d"; green = "#98971a"; yellow = "#d79921"; blue = "#458588"; magenta = "#b16286"; cyan = "#689d6a"; white = "#a89984"; };
        bright = { black = "#928374"; red = "#fb4934"; green = "#b8bb26"; yellow = "#fabd2f"; blue = "#83a598"; magenta = "#d3869b"; cyan = "#8ec07c"; white = "#ebdbb2"; };
      };
    };
  };

  # Разрешаем установку несвободных пакетов
  nixpkgs.config.allowUnfree = true;

  # Обязательная строка.
  system.stateVersion = "23.11"; 
}
