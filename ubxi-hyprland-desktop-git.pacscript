pkgname="ubxi-hyprland-desktop-git"
pkgname=("ubxi-hyprland-desktop-git")
arch=('amd64' 'arm64')
pkgver="1.0.0"
pkgrel="1"
epoch="1"
url='https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git'
source=(
  "https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git"
)
sha256sums=("SKIP")

depends=("hyprland" "waybar" "alacritty" "wofi" "thunar" "wl-clipboard" "dunst" "xdg-desktop-portal-hyprland" "grim" "slurp" "adw-gtk-theme")
makedepends=("git" "unzip")
optdepends=(
  "swaylock: for locking the screen"
  "wlogout: for loging out"
)
pacdeps=("rhino-ubxi-core")
replaces=("unicorn-desktop")
priority='required'
pkgdesc="UBXI Hyprland Desktop"
license=('CC BY NC 4.0')
external_connection=true
incompatible=('debian:*')
maintainer=("Bisher Al Masri <bisherk.almasri@gmail.com>")
gives="ubxi-hyprland-desktop"

build() {
  cd "${gives}"
  mkdir -p "${pkgdir}/usr/share/wallpapers/rhino"
  mkdir -p "${pkgdir}/$HOME/.config/hypr"
  mkdir -p "${pkgdir}/$HOME/.config/waybar"
  mkdir -p "${pkgdir}/$HOME/.config/alacritty"
  mkdir -p "${pkgdir}/$HOME/.config/wofi"
}

package() {
  cd "${gives}"
  install -Dm644 config/hypr/hyprland.conf "${pkgdir}/$HOME/.config/hypr/hyprland.conf"
  install -Dm644 config/hypr/hyprpaper.conf "${pkgdir}/$HOME/.config/hypr/hyprpaper.conf"
  install -Dm644 config/waybar/config "${pkgdir}/$HOME/.config/waybar/config"
  install -Dm644 config/waybar/style.css "${pkgdir}/$HOME/.config/waybar/style.css"
  install -Dm644 config/alacritty/alacritty.toml "${pkgdir}/$HOME/.config/alacritty/alacritty.toml"
  install -Dm644 config/alacritty/unicorn.toml "${pkgdir}/$HOME/.config/alacritty/unicorn.toml"
  install -Dm644 config/wofi/config "${pkgdir}/$HOME/.config/wofi/config"
  install -Dm644 config/wofi/style.css "${pkgdir}/$HOME/.config/wofi/style.css"

  install -Dm644 config/hypr/rhino/1.png "${pkgdir}/usr/share/wallpapers/rhino/1.png"
  install -Dm644 config/hypr/rhino/2.png "${pkgdir}/usr/share/wallpapers/rhino/2.png"
}

post_install() {
  echo "UBXI Hyprland Desktop has been installed."
}

post_remove() {
  echo "UBXI Hyprland Desktop has been removed."
}

