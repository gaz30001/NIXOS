# /etc/nixos/configuration.nix
# Конфигурация для ноутбука с AMD Athlon Neo MV-40 и ATI Radeon Xpress 1200

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # --- Загрузчик GRUB для системы с BIOS (Non-EFI) ---
  # Устанавливаем GRUB на диск /dev/sda. Если ваш диск называется иначе, измените здесь.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  # --- Сеть ---
  networking.hostName = "nixos-athlon"; # Имя компьютера в сети
  networking.networkmanager.enable = true;

  # --- Локализация и время ---
  time.timeZone = "Europe/Moscow";
  i18n.setDefaultLocale = "ru_RU.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "ru";
  };

  # --- Пользователь oleg ---
  users.users.oleg = {
    isNormalUser = true;
    description = "Oleg";
    initialPassword = "tronik"; # Не забудьте сменить после первого входа
    extraGroups = [ "wheel" "networkmanager" ]; # 'wheel' дает права sudo
  };

  # --- Графическая подсистема (Xorg) ---
  services.xserver = {
    enable = true;

    # Явно указываем драйвер для вашей видеокарты ATI Radeon Xpress
    videoDrivers = [ "ati" ];

    # Включаем оконный менеджер bspwm
    windowManager.bspwm.enable = true;
    
    # Отключаем менеджер входа (login manager), будем входить через консоль
    displayManager.none = true;
    
    # Запускать X-сервер (графику) автоматически после входа в tty1
    startxatlogin = true;
    
    # Раскладка клавиатуры для графической сессии
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };
  
  # --- Пакеты ---
  environment.systemPackages = with pkgs; [
    # Основа
    git
    neovim
    unzip
    
    # Окружение bspwm
    bspwm
    sxhkd # для горячих клавиш
    polybar # статус-бар
    rofi # меню запуска
    pcmanfm # файловый менеджер
    ranger # консольный файловый менеджер
    alacritty # терминал
    feh # для установки обоев
    dmenu # альтернативное меню
    
    # Браузер
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

  # Обязательная строка. Указывает версию NixOS.
  # Используйте ту версию, которую скачали (например, 23.11 или 24.05)
  system.stateVersion = "23.11"; 
}
