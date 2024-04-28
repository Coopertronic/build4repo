# Maintainer: Matthew Phillip Cooper <matthew@coopertronic.co.uk>
pkgname=build4repo
_destname1="/usr"
pkgver=1.r143.245b816
pkgrel=2
pkgdesc="Builds the current package and then cleans up the downloaded folders after copying the zst files to the side repo, ready for upload."
arch=('any')
url="https://github.com/Coopertronic/build4repo.git"
license=('GPL2')
makedepends=('git' 'go-md2man')
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
    install -d $pkgdir/usr/share/man/man1
    install -d $pkgdir/usr/share/doc/$pkgname
    go-md2man -in $srcdir/$pkgname/README.md -out $srcdir/$pkgname/$pkgname.1
    install -D -m644 $srcdir/$pkgname/$pkgname.1 $pkgdir/usr/share/man/man1/$pkgname.1
    install -D -m644 $srcdir/$pkgname/README.md $pkgdir/usr/share/doc/$pkgname/README.md
}
