pkgname="ubxi-hyprland-desktop-git"
gives="${pkgname%-git}"
arch=('amd64' 'arm64')
pkgver="0.0.1"
url='https://github.com/BISHER-AL-MASRI/ubxi-hyprland-desktop-git'
source=("${gives}::${url}.git")

depends=(
  "waybar" "alacritty" "wofi" "thunar"
  "wl-clipboard" "dunst" "xdg-desktop-portal-hyprland"
  "grim" "slurp"
)
optdepends=(
  "swaylock: for locking the screen"
  "wlogout: for logging out"
)
pacdeps=("rhino-ubxi-core" "hyprland-bin" "adw-gtk3")
replaces=("unicorn-desktop")
priority='required'
pkgdesc="UBXI Hyprland Desktop Environment"
incompatible=('debian:*')
maintainer=("Bisher Al Masri <bisherk.almasri@gmail.com>")

pre_install() {
  echo "Preventing Waybar from installing configuration files in /etc/xdg/waybar..."
  
  if [ -d /etc/xdg/waybar ]; then
    for file in /etc/xdg/waybar/*; do
      [ -e "$file" ] || continue
      dpkg-divert --add --rename --divert "${file}.bak" "$file"
    done
  fi
}

build() {
  mkdir -p "${pkgdir}/etc/xdg"
  mkdir -p "${pkgdir}/etc/skel/.config"
  mkdir -p "${pkgdir}/usr/share/wallpapers/rhino/"
}

package() {
  cd "${gives}"

  if ! [ -f /etc/xdg/waybar.bak ]; then
    cp -r config/waybar "${pkgdir}/etc/xdg"
  fi

  cp -r config/hypr "${pkgdir}/etc/xdg"
  cp -r config/alacritty "${pkgdir}/etc/xdg"
  cp -r config/wofi "${pkgdir}/etc/skel/.config/"

  # Copy wallpapers
  cp -r config/hypr/rhino "${pkgdir}/usr/share/wallpapers/"
}

post_remove() {
  echo "Restoring Waybar configuration files..."
  
  if [ -d /etc/xdg/waybar ]; then
    for file in /etc/xdg/waybar/*.bak; do
      original="${file%.bak}"
      [ -e "$file" ] || continue
      dpkg-divert --rename --remove "$original"
    done
  fi
}
