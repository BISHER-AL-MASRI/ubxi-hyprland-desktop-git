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
makedepends=("git")
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
license=('GPL-3.0-or-later')

package() {
    cd "${srcdir}/${pkgname}"
    
    # Install Hyprland configuration files to /etc/skel (new user templates)
    install -Dm644 config/hypr/hyprland.conf "${pkgdir}/etc/skel/.config/hypr/hyprland.conf"
    install -Dm644 config/hypr/hyprpaper.conf "${pkgdir}/etc/skel/.config/hypr/hyprpaper.conf"
    
    # Install wallpapers to system-wide directory
    install -Dm644 config/hypr/rhino/1.png "${pkgdir}/usr/share/backgrounds/ubxi-hyprland/1.png"
    install -Dm644 config/hypr/rhino/2.png "${pkgdir}/usr/share/backgrounds/ubxi-hyprland/2.png"
    
    # Install Waybar configuration and styles
    install -Dm644 config/waybar/config "${pkgdir}/etc/skel/.config/waybar/config"
    install -Dm644 config/waybar/style.css "${pkgdir}/etc/skel/.config/waybar/style.css"
    
    # Install Alacritty terminal configurations
    install -Dm644 config/alacritty/alacritty.toml "${pkgdir}/etc/skel/.config/alacritty/alacritty.toml"
    install -Dm644 config/alacritty/unicorn.toml "${pkgdir}/etc/skel/.config/alacritty/unicorn.toml"
    
    # Install Wofi launcher configuration and styles
    install -Dm644 config/wofi/config "${pkgdir}/etc/skel/.config/wofi/config"
    install -Dm644 config/wofi/style.css "${pkgdir}/etc/skel/.config/wofi/style.css"
    
    # Install licenses and documentation
    install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
    install -Dm644 README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"
}

post_install() {
    echo -e "\033[1;32mUBXI Hyprland Desktop configuration installed!\033[0m"
    echo "Default configurations are placed in /etc/skel/.config."
    echo "For existing users, manually copy the configurations to ~/.config/:"
    echo "  cp -r /etc/skel/.config/hypr ~/.config/"
    echo "  cp -r /etc/skel/.config/waybar ~/.config/"
    echo "  cp -r /etc/skel/.config/alacritty ~/.config/"
    echo "  cp -r /etc/skel/.config/wofi ~/.config/"
}
