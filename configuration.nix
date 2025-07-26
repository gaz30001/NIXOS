{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # без цифры!
  boot.loader.timeout = 1;
  boot.supportedFilesystems = [ "btrfs" ];

  fileSystems."/" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "compress=zstd:2" "ssd" "noatime" "discard=async" "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "compress=zstd:2" "ssd" "noatime" "discard=async" "subvol=@home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "compress=zstd:2" "ssd" "noatime" "discard=async" "subvol=@nix" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "compress=zstd:2" "ssd" "noatime" "discard=async" "subvol=@log" ];
  };

  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  fileSystems."/swap" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  swapDevices = [{
    device = "/.swapvol/swapfile";
  }];

  networking.hostName = "nix";
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "ru_RU.UTF-8";
  console.keyMap = "ruwin_cpl";

  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";

  environment.systemPackages = with pkgs; [
    git
    nvim
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

  users.users.oleg = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  services.openssh.enable = true;

  system.stateVersion = "24.05";
}