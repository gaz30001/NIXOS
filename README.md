# 🧊 NixOS BSPWM Minimal Setup (MSI U210 Light)

Лёгкая NixOS-система на Btrfs с BSPWM, Polybar, Rofi, Gruvbox-оформлением и браузером Qutebrowser.

## Состав
- WM: bspwm + sxhkd
- Network: networkmanager
- Terminal: alacritty
- File Managers: ranger, pcmanfm
- Theme: gruvbox, papirus icons
- Browser: qutebrowser

## Установка

```bash
git clone https://github.com/gaz30001/NIXOS
cp -r nixos-config/* /mnt/etc/nixos/
nixos-install
