# Maintainer: Matthew Phillip Cooper <matthew@coopertronic.co.uk>
pkgname=build4repo
_destname1="/usr"
pkgver=1.r142.ce5a6bf
pkgrel=2
pkgdesc="Builds the current package and then cleans up the downloaded folders after copying the zst files to the side repo, ready for upload."
arch=('any')
url="https://github.com/Coopertronic/build4repo.git"
license=('GPL2')
makedepends=('git')
depends=('git' 'ctos-functions' 'git-helper' 'sshpass')
conflicts=()
provides=("${pkgname}")
options=(!strip !emptydirs)
source=("git+$url")
sha256sums=('SKIP')

pkgver() {
    cd "${srcdir}/${pkgname}"
    printf "1.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
    ##  Install Scripts
    install -dm755 ${pkgdir}${_destname1}
    cp -r ${srcdir}/${pkgname}${_destname1}/* ${pkgdir}${_destname1}

    ##  Install documentation
    install -d $pkgdir/usr/share/doc/$pkgname
    install -D -m644 $srcdir/$pkgname/README $pkgdir/usr/share/doc/$pkgname/README
}
