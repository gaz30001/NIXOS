# 🧊 NixOS Minimal Setup (BSPWM Edition) for MSI U210 Light

Мой личный конфиг для минималистичной системы NixOS на базе оконного менеджера BSPWM. Лёгкий, красивый (в стиле Gruvbox), идеален для слабых ноутов вроде MSI U210.

## Состав

- **WM**: BSPWM + SXHKD
- **Файловые менеджеры**: Ranger, PCManFM
- **Браузер**: Qutebrowser
- **Темы**: Gruvbox + Papirus
- **ФС**: Btrfs
- **Терминал**: Alacritty
- **Редактор**: Neovim
- **Панель**: Polybar

## Установка

```bash
git clone git@github.com:gaz30001/nixos-config.git
cp nixos-config/* /mnt/etc/nixos/
nixos-install
