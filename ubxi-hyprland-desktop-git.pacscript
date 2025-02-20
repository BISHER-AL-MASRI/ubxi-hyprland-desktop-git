pkgname="ubxi-hyprland-desktop-git"
gives="${pkgname%-git}"
arch=('amd64' 'arm64')
pkgver="0.0.1"
url='https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git'
source=("${gives}::${url}.git")
depends=(
  "hyprland" "waybar" "alacritty" "wofi" "thunar"
  "wl-clipboard" "dunst" "xdg-desktop-portal-hyprland"
  "grim" "slurp"
)
optdepends=(
  "swaylock: for locking the screen"
  "wlogout: for logging out"
)
pacdeps=("rhino-ubxi-core" "adw-gtk3")
replaces=("unicorn-desktop")
priority='required'
pkgdesc="UBXI Hyprland Desktop Environment"
maintainer=("Bisher Al Masri <bisherk.almasri@gmail.com>")
compatible=("ubuntu:oracular" "ubuntu:devel")

pre_install() {
  echo "Preventing Waybar from installing configuration files in /etc/xdg/waybar..."
  
  sudo dpkg-divert --quiet --package "${pkgname}" --divert /etc/xdg/waybar/style.css.bak --rename /etc/xdg/waybar/style.css
  sudo dpkg-divert --quiet --package "${pkgname}" --divert /etc/xdg/waybar/config.jsonc.bak --rename /etc/xdg/waybar/config.jsonc

  mkdir -p "${pkgdir}/etc/xdg/waybar/"
}

build() {
  mkdir -p "${pkgdir}/etc/xdg"
  mkdir -p "${pkgdir}/etc/skel/.config"
  mkdir -p "${pkgdir}/usr/share/wallpapers/rhino/"
}

package() {
  cd "${gives}"

  cp -r config/waybar/* "${pkgdir}/etc/xdg/waybar/"

  cp -r config/hypr "${pkgdir}/etc/xdg"
  cp -r config/alacritty "${pkgdir}/etc/xdg"
  cp -r config/wofi "${pkgdir}/etc/skel/.config/"

  # Copy wallpapers
  cp -r config/hypr/rhino "${pkgdir}/usr/share/wallpapers/"
}

post_remove() {
  echo "Restoring Waybar configuration files..."
  
  sudo dpkg-divert --quiet --package "${pkgname}" --remove --rename /etc/xdg/waybar/config.jsonc
  sudo dpkg-divert --quiet --package "${pkgname}" --remove --rename /etc/xdg/waybar/style.css
}
