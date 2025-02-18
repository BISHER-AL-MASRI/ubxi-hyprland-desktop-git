pkgname="ubxi-hyprland-desktop-git"
arch=('amd64' 'arm64')
pkgver="1.0.0"
pkgrel="1"
epoch="1"
url='https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git'
source=("git+https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git.git")
sha256sums=("SKIP")

depends=(
  "hyprland" "waybar" "alacritty" "wofi" "thunar"
  "wl-clipboard" "dunst" "xdg-desktop-portal-hyprland"
  "grim" "slurp" "adw-gtk-theme"
)
makedepends=("git" "unzip")
optdepends=(
  "swaylock: for locking the screen"
  "wlogout: for logging out"
)
pacdeps=("rhino-ubxi-core")
replaces=("unicorn-desktop")
priority='required'
pkgdesc="UBXI Hyprland Desktop Environment"
external_connection=true
incompatible=('debian:*')
maintainer=("Bisher Al Masri <bisherk.almasri@gmail.com>")
gives="ubxi-hyprland-desktop-git"

build() {
  cd "${gives}"
  mkdir -p "${pkgdir}/usr/share/wallpapers/rhino/"
  mkdir -p "${pkgdir}/etc/skel/.config/"

}

package() {
  cd "${gives}"

  # Copy all configuration files
  cp -r config/hypr "${pkgdir}/etc/skel/.config/"
  cp -r config/waybar "${pkgdir}/etc/skel/.config/"
  cp -r config/alacritty "${pkgdir}/etc/skel/.config/"
  cp -r config/wofi "${pkgdir}/etc/skel/.config/"

  # Copy wallpapers
  cp -r config/hypr/rhino "${pkgdir}/usr/share/wallpapers/"
}

