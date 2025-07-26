# /etc/nixos/configuration.nix

{ config, pkgs, ... }:

{
  imports =
    [ # Сюда можно добавлять пути к другим файлам .nix для модульности
      ./hardware-configuration.nix
    ];

  # --- Загрузчик GRUB для систем с BIOS/MBR ---
  # Устанавливаем GRUB на диск, а не на раздел.
  # Замените "sda" на ваш диск (например, "vda" или "hda").
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  # --- Сеть ---
  # Используем NetworkManager для удобного управления Wi-Fi и Ethernet.
  networking.hostName = "nixos-bspwm"; # Можете изменить
  networking.networkmanager.enable = true;

  # --- Локализация и время ---
  time.timeZone = "Europe/Moscow"; # Установите вашу временную зону

  i18n.setDefaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # --- Пользователь ---
  users.users.oleg = {
    isNormalUser = true;
    description = "Oleg";
    initialPassword = "tronik";
    # Добавляем пользователя в группу 'wheel' для прав sudo
    # и 'networkmanager' для управления сетями.
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # --- Установка пакетов ---
  # Все пакеты, которые будут доступны в системе.
  environment.systemPackages = with pkgs; [
    # Основные утилиты
    git
    neovim # nvim
    unzip

    # Оконный менеджер и его окружение
    bspwm
    sxhkd
    polybar
    rofi
    dmenu
    pcmanfm
    ranger
    alacritty
    feh # для установки обоев

    # Браузер
    qutebrowser
  ];

  # --- Настройка графической среды (X11) ---
  services.xserver = {
    enable = true;
    # Включаем оконный менеджер bspwm
    windowManager.bspwm.enable = true;
    # Отключаем стандартный display manager, т.к. будем логиниться через консоль
    displayManager.none = true;
    # Запускаем X-сервер автоматически после логина в tty1
    startxatlogin = true;
  };

  # --- Шрифты ---
  # Добавляем популярные шрифты для лучшего отображения
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  # --- Тема Gruvbox (базовая настройка) ---
  # Для полного применения темы нужно будет создать dotfiles (~/.config/...)

  # Alacritty (терминал)
  programs.alacritty = {
    enable = true;
    settings = {
      # Настройки шрифта
      font = {
        normal = { family = "FiraCode Nerd Font"; style = "Regular"; };
        size = 11;
      };
      # Схема Gruvbox
      colors = {
        primary = { background = "#282828"; foreground = "#ebdbb2"; };
        normal = {
          black = "#282828"; red = "#cc241d"; green = "#98971a"; yellow = "#d79921";
          blue = "#458588"; magenta = "#b16286"; cyan = "#689d6a"; white = "#a89984";
        };
        bright = {
          black = "#928374"; red = "#fb4934"; green = "#b8bb26"; yellow = "#fabd2f";
          blue = "#83a598"; magenta = "#d3869b"; cyan = "#8ec07c"; white = "#ebdbb2";
        };
      };
    };
  };

  # --- Разрешаем установку unfree (несвободных) пакетов, если понадобится ---
  nixpkgs.config.allowUnfree = true;

  # --- Системная информация ---
  # Эта строчка обязательна
  system.stateVersion = "23.11"; # Используйте версию NixOS, которую устанавливаете
}
