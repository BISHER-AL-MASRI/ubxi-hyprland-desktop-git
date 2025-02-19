pkgname="ubxi-hyprland-desktop-git"
arch=('amd64' 'arm64')
pkgver="1.0.0"
pkgrel="1"
epoch="1"
url='https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git'
source=("git+https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git.git")
sha256sums=("SKIP")

depends=(
  "waybar" "alacritty" "wofi" "thunar"
  "wl-clipboard" "dunst" "xdg-desktop-portal-hyprland"
  "grim" "slurp" "adw-gtk3"
)
makedepends=("git" "unzip")
optdepends=(
  "swaylock: for locking the screen"
  "wlogout: for logging out"
)
pacdeps=("rhino-ubxi-core" "hyprland-bin")
replaces=("unicorn-desktop")
priority='required'
pkgdesc="UBXI Hyprland Desktop Environment"
external_connection=true
incompatible=('debian:*')
maintainer=("Bisher Al Masri <bisherk.almasri@gmail.com>")
gives="ubxi-hyprland-desktop-git"

build() {
  mkdir -p "${pkgdir}/etc/xdg"
  mkdir -p "${pkgdir}/etc/skel/.config"
}

package() {
  cd "${gives}"
  # Copy all configuration files
  cp -r config/hypr/rhino "${pkgdir}/usr/share/wallpapers/"
  cp -r config/hypr "${pkgdir}/etc/xdg"
  cp -r config/waybar "${pkgdir}/etc/xdg"
  cp -r config/alacritty "${pkgdir}/etc/skel/.config/"
  cp -r config/wofi "${pkgdir}/etc/skel/.config/"
  # Copy wallpapers
}

post_install() {
  fancy_message info "IMPORTTANT: Finished Installation, make sure to copy alacritty and wofi to other users if you want from /etc/skel/alacritty or wofi. \n Run cp -r /etc/skel/{alacritty,wofi} ~/.config/"
}

