
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
gives="ubxi-hyprland-desktop"

build() {
  cd "${srcdir}/ubxi-hyprland-desktop-git"
}

package() {
  cd "${srcdir}/ubxi-hyprland-desktop-git"
  
  # Ensure directories exist
  install -d "${pkgdir}/etc/skel/.config/hypr"
  install -d "${pkgdir}/etc/skel/.config/waybar"
  install -d "${pkgdir}/etc/skel/.config/alacritty"
  install -d "${pkgdir}/etc/skel/.config/wofi"
  install -d "${pkgdir}/usr/share/wallpapers/rhino"

  # Install configuration files
  install -Dm644 config/hypr/hyprland.conf "${pkgdir}/etc/skel/.config/hypr/hyprland.conf"
  install -Dm644 config/hypr/hyprpaper.conf "${pkgdir}/etc/skel/.config/hypr/hyprpaper.conf"
  install -Dm644 config/waybar/config "${pkgdir}/etc/skel/.config/waybar/config"
  install -Dm644 config/waybar/style.css "${pkgdir}/etc/skel/.config/waybar/style.css"
  install -Dm644 config/alacritty/alacritty.toml "${pkgdir}/etc/skel/.config/alacritty/alacritty.toml"
  install -Dm644 config/alacritty/unicorn.toml "${pkgdir}/etc/skel/.config/alacritty/unicorn.toml"
  install -Dm644 config/wofi/config "${pkgdir}/etc/skel/.config/wofi/config"
  install -Dm644 config/wofi/style.css "${pkgdir}/etc/skel/.config/wofi/style.css"

  # Install wallpapers
  install -Dm644 config/hypr/rhino/1.png "${pkgdir}/usr/share/wallpapers/rhino/1.png"
  install -Dm644 config/hypr/rhino/2.png "${pkgdir}/usr/share/wallpapers/rhino/2.png"
}

post_install() {
  echo "UBXI Hyprland Desktop has been installed."
}

post_remove() {
  echo "UBXI Hyprland Desktop has been removed."
}
